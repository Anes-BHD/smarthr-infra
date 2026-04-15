# ── Secrets Manager — DB_HOST ─────────────────────────────────────────────────
resource "aws_secretsmanager_secret" "db_host" {
  name                    = "${var.project}/DB_HOST"
  description             = "SmartHR RDS endpoint"
  recovery_window_in_days = 7
}

resource "aws_secretsmanager_secret_version" "db_host" {
  secret_id     = aws_secretsmanager_secret.db_host.id
  secret_string = var.db_host
}

# ── Secrets Manager — APP_KEY ─────────────────────────────────────────────────
resource "aws_secretsmanager_secret" "app_key" {
  name                    = "${var.project}/APP_KEY"
  description             = "Laravel application key"
  recovery_window_in_days = 7
}

resource "aws_secretsmanager_secret_version" "app_key" {
  secret_id     = aws_secretsmanager_secret.app_key.id
  secret_string = var.app_key
}

# ── Secrets Manager — DB_PASSWORD ─────────────────────────────────────────────
resource "aws_secretsmanager_secret" "db_password" {
  name                    = "${var.project}/DB_PASSWORD"
  description             = "SmartHR RDS password"
  recovery_window_in_days = 7
}

resource "aws_secretsmanager_secret_version" "db_password" {
  secret_id     = aws_secretsmanager_secret.db_password.id
  secret_string = var.db_password
}
