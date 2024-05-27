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
  name    = tolist(aws_acm_certificate.ecs_domain_certificate.domain_validation_options)[0].resource_record_name
  type    = tolist(aws_acm_certificate.ecs_domain_certificate.domain_validation_options)[0].resource_record_type
  zone_id = data.aws_route53_zone.ecs_domain.zone_id
  records = [tolist(aws_acm_certificate.ecs_domain_certificate.domain_validation_options)[0].resource_record_value]
  ttl     = 60
  allow_overwrite = true   
}

resource "aws_acm_certificate_validation" "ecs_domain_certificate_validation" {
  certificate_arn         = aws_acm_certificate.ecs_domain_certificate.arn
  validation_record_fqdns = [aws_route53_record.ecs_cert_validation_record.fqdn]
}

resource "aws_route53_record" "ecs_load_balancer_record" {
    name = "*.${var.domain_name}"
    type = "A"
    zone_id = data.aws_route53_zone.ecs_domain.zone_id

    alias {
        name = aws_lb.ecs_cluster_lb.dns_name
        zone_id = aws_lb.ecs_cluster_lb.zone_id
        evaluate_target_health = false
    }
}