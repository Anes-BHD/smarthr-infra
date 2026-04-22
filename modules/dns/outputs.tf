output "zone_id" {
  description = "Route 53 hosted zone ID"
  value       = aws_route53_zone.main.zone_id
}

output "name_servers" {
  description = "Route 53 NS records — these must match what GoDaddy points to"
  value       = aws_route53_zone.main.name_servers
}

output "smarthr_fqdn" {
  description = "Full DNS name of the app record"
  value       = aws_route53_record.smarthr.fqdn
}
