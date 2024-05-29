#parent hosted zone
data "aws_route53_zone" "parent_domain" {
  name          = var.main_domain_name
  private_zone  = false
}

#child hosted zone creation
resource "aws_route53_zone" "sub_domain" {
  name          = "${var.sub_domain_name}.${var.main_domain_name}"
}

#make a name server record in the parent hosted zone
resource "aws_route53_record" "ns_record_test" {
  zone_id = data.aws_route53_zone.parent_domain.zone_id
  name    = var.sub_domain_name
  type    = "NS"
  ttl     = "300"
  records = ["${aws_route53_zone.sub_domain.name_servers}"]
}

# resource "aws_route53_record" "sub_domain_cert_validation_record" {
#   name    = tolist(aws_acm_certificate.sub_domain_certificate.domain_validation_options)[0].resource_record_name
#   type    = tolist(aws_acm_certificate.sub_domain_certificate.domain_validation_options)[0].resource_record_type
#   zone_id = aws_route53_zone.sub_domain.zone_id
#   records = [tolist(aws_acm_certificate.sub_domain_certificate.domain_validation_options)[0].resource_record_value]
#   ttl     = "300"
#   allow_overwrite = true   
# }

resource "aws_route53_record" "sub_domain_cert_validation_record" {
  for_each = {
    for dvo in aws_acm_certificate.sub_domain_certificate.domain_validation_options : dvo.domain_name => {
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
  zone_id         = aws_route53_zone.sub_domain.zone_id
}

resource "aws_route53_record" "sub_domain_load_balancer_record" {
    name = "${var.sub_domain_name}.${var.main_domain_name}"
    type = "A"
    zone_id = aws_route53_zone.sub_domain.zone_id

    alias {
        name = var.aws_lb_ecs_cluster_lb_dns_name
        zone_id = var.aws_lb_ecs_cluster_lb_zone_id
        evaluate_target_health = true
    }
}