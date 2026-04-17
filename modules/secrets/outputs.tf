output "db_host_arn" { value = aws_secretsmanager_secret.db_host.arn }
output "app_key_arn" { value = aws_secretsmanager_secret.app_key.arn }
output "db_password_arn" { value = aws_secretsmanager_secret.db_password.arn }
