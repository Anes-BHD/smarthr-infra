variable "project" {
  description = "Project name used as prefix for all resources"
  type        = string
  default     = "smarthr"
}

variable "environment" {
  description = "Deployment environment"
  type        = string
  default     = "production"
}

variable "aws_region" {
  description = "AWS region"
  type        = string
  default     = "us-east-1"
}

variable "vpc_cidr" {
  description = "CIDR block for the VPC"
  type        = string
  default     = "10.0.0.0/24"
}

variable "certificate_arn" {
  description = "ACM certificate ARN for HTTPS listener"
  type        = string
}

variable "app_domain" {
  description = "Application domain name"
  type        = string
  default     = "smarthr.anesbhd.com"
}

variable "app_key" {
  description = "Laravel APP_KEY"
  type        = string
  sensitive   = true
}

variable "db_password" {
  description = "RDS master password"
  type        = string
  sensitive   = true
}

variable "backend_image" {
  description = "ECR URI for backend (PHP-FPM) image"
  type        = string
}

variable "web_image" {
  description = "ECR URI for web (Nginx) image"
  type        = string
}

variable "redis_image" {
  description = "ECR URI for Redis image"
  type        = string
}

variable "alert_email" {
  description = "Email address for CloudWatch alarm notifications"
  type        = string
}
