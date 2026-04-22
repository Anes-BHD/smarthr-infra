# ── A Record (Alias) — smarthr.anesbhd.com → ALB ─────────────────────────────
# Depends on ALB existing — created after ALB is provisioned.
#
# Import existing record:
#   terraform import module.dns_record.aws_route53_record.smarthr \
#     Z0161128KCIOXNK1OQEQ_smarthr.anesbhd.com_A
resource "aws_route53_record" "smarthr" {
  zone_id = var.zone_id
  name    = var.app_subdomain
  type    = "A"

  alias {
    name                   = var.alb_dns_name
    zone_id                = var.alb_zone_id
    evaluate_target_health = true
  }
}

# ── Nameserver reminder (printed once after apply) ────────────────────────────
resource "terraform_data" "ns_reminder" {
  input = var.name_servers

  provisioner "local-exec" {
    command = <<-EOT
      echo ""
      echo "========================================================"
      echo "If hosted zone was recreated, update GoDaddy nameservers:"
      printf '%s\n' ${join(" ", var.name_servers)}
      echo "Go to: https://dcc.godaddy.com/manage/dns"
      echo "========================================================"
    EOT
  }
}
