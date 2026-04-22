# ─────────────────────────────────────────────────────────────────────────────
# SmartHR — Route 53 DNS module
#
# Manages:
#   - Public hosted zone: anesbhd.com (Z0161128KCIOXNK1OQEQ) — already exists
#   - A record (Alias): smarthr.anesbhd.com → ALB DNS name — already exists
#
# Import before first apply:
#   terraform import module.dns.aws_route53_zone.main Z0161128KCIOXNK1OQEQ
#   terraform import module.dns.aws_route53_record.smarthr Z0161128KCIOXNK1OQEQ_smarthr.anesbhd.com_A
# ─────────────────────────────────────────────────────────────────────────────

# ── Public Hosted Zone ────────────────────────────────────────────────────────
# This already exists — import it, don't recreate it.
# The NS and SOA records are auto-managed by Route 53, do not touch them.
resource "aws_route53_zone" "main" {
  name    = var.root_domain
  comment = "SmartHR public hosted zone"
}

# ── A Record (Alias) — smarthr.anesbhd.com → ALB ─────────────────────────────
resource "aws_route53_record" "smarthr" {
  zone_id = aws_route53_zone.main.zone_id
  name    = var.app_subdomain
  type    = "A"

  alias {
    name                   = var.alb_dns_name
    zone_id                = var.alb_zone_id
    evaluate_target_health = true
  }
}

# ── Reminder: update GoDaddy nameservers after every apply ───────────────────
# If the hosted zone is recreated, AWS assigns new NS records.
# Run `terraform output route53_name_servers` and update GoDaddy manually.
resource "terraform_data" "ns_reminder" {
  input = aws_route53_zone.main.name_servers

  provisioner "local-exec" {
    command = <<-EOT
      echo ""
      echo "========================================================"
      echo "ACTION REQUIRED — update GoDaddy nameservers to:"
      echo "${join("\n", aws_route53_zone.main.name_servers)}"
      echo "Go to: https://dcc.godaddy.com/manage/dns"
      echo "========================================================"
    EOT
  }
}
