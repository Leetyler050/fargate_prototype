resource "aws_acm_certificate" "ecs_domain_certificate" {
  domain_name = "*.${var.domain_name}"
  validation_method = "DNS"

  tags = {
    Name ="cert-${var.ecs_cluster_name}"
  }
}

data "aws_route53_zone" "ecs_domain" {
  name          = var.domain_name
  private_zone  = false
}

resource "aws_route53_record" "ecs_cert_validation_record" {
  name    = aws_acm_certificate.ecs_domain_certificate.domain_validation_options.0.resource_record_name
  type    = aws_acm_certificate.ecs_domain_certificate.domain_validation_options.0.resource_record_type
  zone_id = data.aws_route53_zone.ecs_domain.zone_id
  records = [aws_acm_certificate.ecs_domain_certificate.domain_validation_options.0.resource_record_value]
  ttl     = 60
  allow_overwrite = true

#   alias {
#     name                   = aws_alb.ecs_cluster_alb.dns_name
#     zone_id                = aws_alb.ecs_cluster_alb.zone_id
#     evaluate_target_health = true
#   }
}

resource "aws_acm_certificate_validation" "ecs_domain_certificate_validation" {
  certificate_arn         = aws_acm_certificate.ecs_domain_certificate.arn
  validation_record_fqdns = [aws_route53_record.ecs_cert_validation_record.fqdn]
}

