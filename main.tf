terraform {
  required_version = ">= 1.5"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
  backend "s3" {
    bucket         = "smarthr-terraform-state"
    key            = "smarthr/terraform.tfstate"
    region         = "us-east-1"
    encrypt        = true
    dynamodb_table = "smarthr-terraform-locks"
  }
}

provider "aws" {
  region = var.aws_region
  default_tags {
    tags = {
      Project     = var.project
      Environment = var.environment
      ManagedBy   = "terraform"
    }
  }
}

module "vpc" {
  source      = "./modules/vpc"
  project     = var.project
  environment = var.environment
  vpc_cidr    = var.vpc_cidr
}

module "secrets" {
  source      = "./modules/secrets"
  project     = var.project
  db_host     = module.rds.endpoint
  app_key     = var.app_key
  db_password = var.db_password

  depends_on = [module.rds]
}

module "alb" {
  source            = "./modules/alb"
  project           = var.project
  environment       = var.environment
  vpc_id            = module.vpc.vpc_id
  public_subnet_ids = module.vpc.public_subnet_ids
  certificate_arn   = var.certificate_arn
}

module "rds" {
  source             = "./modules/rds"
  project            = var.project
  environment        = var.environment
  vpc_id             = module.vpc.vpc_id
  private_subnet_ids = module.vpc.private_subnet_ids
  db_password        = var.db_password
  app_sg_id          = ""

  depends_on = [module.vpc]
}

# Create the security group rule after both rds and ecs modules are created
resource "aws_security_group_rule" "rds_ingress_from_ecs" {
  type                     = "ingress"
  from_port                = 3306
  to_port                  = 3306
  protocol                 = "tcp"
  source_security_group_id = module.ecs.app_sg_id
  security_group_id        = module.rds.security_group_id
  description              = "MySQL from ECS app tasks"
}

module "ecs" {
  source                 = "./modules/ecs"
  project                = var.project
  environment            = var.environment
  vpc_id                 = module.vpc.vpc_id
  public_subnet_ids      = module.vpc.public_subnet_ids
  private_subnet_ids     = module.vpc.private_subnet_ids
  alb_target_group_arn   = module.alb.target_group_arn
  alb_sg_id              = module.alb.alb_sg_id
  db_host_secret_arn     = module.secrets.db_host_arn
  app_key_secret_arn     = module.secrets.app_key_arn
  db_password_secret_arn = module.secrets.db_password_arn
  app_domain             = var.app_domain
  backend_image          = var.backend_image
  web_image              = var.web_image
  redis_image            = var.redis_image

  depends_on = [module.alb, module.secrets]
}

