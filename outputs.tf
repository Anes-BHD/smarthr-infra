output "alb_dns_name" {
  description = "ALB DNS name — used as Alias target in Route 53"
  value       = module.alb.alb_dns_name
}

output "vpc_id" {
  description = "VPC ID"
  value       = module.vpc.vpc_id
}

output "rds_endpoint" {
  description = "RDS endpoint"
  value       = module.rds.endpoint
  sensitive   = true
}

output "ecs_cluster_name" {
  description = "ECS cluster name"
  value       = module.ecs.cluster_name
}

output "app_url" {
  description = "Application URL"
  value       = "https://${module.dns.smarthr_fqdn}"
}

output "route53_name_servers" {
  description = "Route 53 NS records — must match GoDaddy nameservers"
  value       = module.dns.name_servers
}
