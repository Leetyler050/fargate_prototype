
#parent hosted zone
data "aws_route53_zone" "parent_domain" {
  name          = var.main_domain_name
  private_zone  = false
}

#child hosted zone
resource "aws_route53_zone" "sub_domain" {
  name          = var.sub_domain

}

resource "aws_route53_record" "dev-ns" {
  zone_id = data.aws_route53_zone.parent_domain.zone_id
  name    = var.sub_domain
  type    = "NS"
  ttl     = 60
  records = aws_route53_zone.sub_domain.name_servers
}

resource "aws_acm_certificate" "sub_domain_certificate" {
  domain_name = "*.${var.sub_domain}"
  validation_method = "DNS"

  tags = {
    Name ="cert-sub-domain_cluster"
  }
}

resource "aws_route53_record" "sub_domain_cert_validation_record" {
  name    = tolist(aws_acm_certificate.sub_domain_certificate.domain_validation_options)[0].resource_record_name
  type    = tolist(aws_acm_certificate.sub_domain_certificate.domain_validation_options)[0].resource_record_type
  zone_id = data.aws_route53_zone.sub_domain.zone_id
  records = [tolist(aws_acm_certificate.sub_domain_certificate.domain_validation_options)[0].resource_record_value]
  ttl     = 60
  allow_overwrite = true   
}

resource "aws_acm_certificate_validation" "sub_domain_certificate_validation" {
  certificate_arn         = aws_acm_certificate.sub_domain_certificate.arn
  validation_record_fqdns = [aws_route53_record.sub_domain_cert_validation_record.fqdn]
}

resource "aws_route53_record" "sub_domain_load_balancer_record" {
    name = "*.${var.sub_domain}"
    type = "A"
    zone_id = data.aws_route53_zone.sub_domain.zone_id

    alias {
        name = aws_lb.ecs_cluster_lb.dns_name
        zone_id = aws_lb.ecs_cluster_lb.zone_id
        evaluate_target_health = false
    }
}