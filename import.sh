#!/bin/bash
# import.sh — Run this ONCE before the first `terraform apply`
# to import resources you already created manually in AWS.
# Safe to re-run: Terraform import is idempotent for state.

set -e

echo "==> Initialising Terraform..."
terraform init -input=false

echo ""
echo "==> Importing VPC resources..."
terraform import module.vpc.aws_vpc.main                          $(aws ec2 describe-vpcs --filters "Name=tag:Name,Values=smarthr-vpc" --query "Vpcs[0].VpcId" --output text)
terraform import module.vpc.aws_internet_gateway.main             $(aws ec2 describe-internet-gateways --filters "Name=tag:Name,Values=smarthr-igw" --query "InternetGateways[0].InternetGatewayId" --output text)

echo ""
echo "==> Importing ECS resources..."
terraform import module.ecs.aws_ecs_cluster.main                  smarthr
terraform import module.ecs.aws_ecs_task_definition.app           arn:aws:ecs:us-east-1:668216279959:task-definition/smarthr-taskdef-app:20
terraform import module.ecs.aws_ecs_task_definition.cache         arn:aws:ecs:us-east-1:668216279959:task-definition/smarthr-taskdef-cache:2

echo ""
echo "==> Importing IAM role..."
# Note: your existing role has a typo (ecsTaskExecustionRole) — import it as-is,
# Terraform will rename it to ecsTaskExecutionRole on next apply.
terraform import module.ecs.aws_iam_role.ecs_task_execution       ecsTaskExecustionRole

echo ""
echo "==> Importing Secrets Manager secrets..."
terraform import module.secrets.aws_secretsmanager_secret.db_host     arn:aws:secretsmanager:us-east-1:668216279959:secret:smarthr/DB_HOST
terraform import module.secrets.aws_secretsmanager_secret.app_key     arn:aws:secretsmanager:us-east-1:668216279959:secret:smarthr/APP_KEY
terraform import module.secrets.aws_secretsmanager_secret.db_password arn:aws:secretsmanager:us-east-1:668216279959:secret:smarthr/DB_PASSWORD

echo ""
echo "==> Importing RDS..."
terraform import module.rds.aws_db_instance.main                  smarthr

echo ""
echo "==> Importing CloudWatch log group..."
terraform import module.ecs.aws_cloudwatch_log_group.main         /ecs/smarthr

echo ""
echo "==> Done. Run 'terraform plan' to verify no destructive changes before applying."
