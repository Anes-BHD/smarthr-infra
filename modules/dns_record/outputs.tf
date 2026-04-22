output "smarthr_fqdn" {
  description = "Fully qualified domain name of the app record"
  value       = aws_route53_record.smarthr.fqdn
}
