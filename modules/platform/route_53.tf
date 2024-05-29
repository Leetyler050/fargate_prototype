data "aws_route53_zone" "ecs_domain" {
  name          = var.domain_name
  private_zone  = false
}

# resource "aws_route53_record" "ecs_cert_validation_record" {
#   name    = tolist(aws_acm_certificate.ecs_domain_certificate.domain_validation_options)[0].resource_record_name
#   type    = tolist(aws_acm_certificate.ecs_domain_certificate.domain_validation_options)[0].resource_record_type
#   zone_id = data.aws_route53_zone.ecs_domain.zone_id
#   records = [tolist(aws_acm_certificate.ecs_domain_certificate.domain_validation_options)[0].resource_record_value]
#   ttl     = 60
#   allow_overwrite = true   
# }

resource "aws_route53_record" "ecs_cert_validation_record" {
  for_each = {
    for dvo in aws_acm_certificate.ecs_domain_certificate.domain_validation_options : dvo.domain_name => {
      name   = dvo.resource_record_name
      record = dvo.resource_record_value
      type   = dvo.resource_record_type
    }
  }

  allow_overwrite = true
  name            = each.value.name
  records         = [each.value.record]
  ttl             = 60
  type            = each.value.type
  zone_id         = data.aws_route53_zone.ecs_domain.zone_id
}

resource "aws_route53_record" "ecs_load_balancer_record" {
    name = "fargate-app.${var.domain_name}"
    type = "A"
    zone_id = data.aws_route53_zone.ecs_domain.zone_id

    alias {
        name = aws_lb.ecs_cluster_lb.dns_name
        zone_id = aws_lb.ecs_cluster_lb.zone_id
        evaluate_target_health = false
    }
}