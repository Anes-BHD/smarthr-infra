output "zone_id" {
  description = "Route 53 hosted zone ID — used by ACM and dns_record modules"
  value       = aws_route53_zone.main.zone_id
}

output "name_servers" {
  description = "NS records — paste these into GoDaddy if zone is recreated"
  value       = aws_route53_zone.main.name_servers
}
