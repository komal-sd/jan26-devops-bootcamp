# ── Data Source — fetch existing hosted zone ──
data "aws_route53_zone" "main" {
  name         = var.domain_name
  private_zone = false
}
#Acm certifaicate
resource "aws_acm_certificate" "main" {
  domain_name       = "${var.app_name}.${var.domain_name}"
  validation_method = "DNS"

  tags = {
    Name = "${var.prefix}-certificate"
  }

  lifecycle {
    create_before_destroy = true
  }
}

# ── Route53 DNS Record ────────────────────
resource "aws_route53_record" "app" {
  zone_id = data.aws_route53_zone.main.zone_id
  name    = "${var.app_name}.${var.domain_name}"
  type    = "A"

  alias {
    name                   = aws_lb.main.dns_name
    zone_id                = aws_lb.main.zone_id
    evaluate_target_health = true
  }
}

# ── ACM Certificate Validation ────────────
resource "aws_route53_record" "cert_validation" {
  for_each = {
    for dvo in aws_acm_certificate.main.domain_validation_options :
    dvo.domain_name => {
      name   = dvo.resource_record_name
      record = dvo.resource_record_value
      type   = dvo.resource_record_type
    }
  }

  zone_id = data.aws_route53_zone.main.zone_id
  name    = each.value.name
  type    = each.value.type
  records = [each.value.record]
  ttl     = 60
}

resource "aws_acm_certificate_validation" "main" {
  certificate_arn         = aws_acm_certificate.main.arn
  validation_record_fqdns = [for record in aws_route53_record.cert_validation : record.fqdn]
}