resource "aws_acm_certificate" "sub_domain_certificate" {
  domain_name = "${var.sub_domain_name}.${var.main_domain_name}"
  validation_method = "DNS"
  subject_alternative_names = ["*.${var.sub_domain_name}.${var.main_domain_name}"]

  tags = {
    Name ="${var.sub_domain_name}-sub-domain-cert"
  }
}

# resource "aws_acm_certificate_validation" "sub_domain_certificate_validation" {
#   certificate_arn         = aws_acm_certificate.sub_domain_certificate.arn
#   validation_record_fqdns = [aws_route53_record.sub_domain_cert_validation_record.fqdn]
# }

resource "aws_acm_certificate_validation" "ecs_domain_certificate_validation" {
  certificate_arn         = aws_acm_certificate.sub_domain_certificate.arn
  validation_record_fqdns = [for record in aws_route53_record.sub_domain_cert_validation_record: record.fqdn]
}