variable "zone_id" {
  description = "Route 53 hosted zone ID from dns_zone module"
  type        = string
}

variable "app_subdomain" {
  description = "Full subdomain for the app (e.g. smarthr.anesbhd.com)"
  type        = string
}

variable "alb_dns_name" {
  description = "ALB DNS name from the alb module output"
  type        = string
}

variable "alb_zone_id" {
  description = "ALB hosted zone ID from the alb module output"
  type        = string
}

variable "name_servers" {
  description = "Route 53 NS records from dns_zone module — for GoDaddy reminder"
  type        = list(string)
}
