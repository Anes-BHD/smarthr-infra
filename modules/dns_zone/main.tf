# ── Public Hosted Zone ────────────────────────────────────────────────────────
# No dependency on ALB — safe to create first.
# ACM uses zone_id output to write validation CNAME records.
#
# Import existing zone:
#   terraform import module.dns_zone.aws_route53_zone.main Z0161128KCIOXNK1OQEQ
resource "aws_route53_zone" "main" {
  name    = var.root_domain
  comment = "SmartHR public hosted zone"
}
