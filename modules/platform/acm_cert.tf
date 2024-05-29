resource "aws_acm_certificate" "ecs_domain_certificate" {
  domain_name = var.domain_name
  validation_method = "DNS"
  subject_alternative_names = ["*.${var.domain_name}"]

  tags = {
    Name ="cert-${var.ecs_cluster_name}"
  }
}

# resource "aws_acm_certificate_validation" "ecs_domain_certificate_validation" {
#   certificate_arn         = aws_acm_certificate.ecs_domain_certificate.arn
#   validation_record_fqdns = [aws_route53_record.ecs_cert_validation_record.fqdn]
# }

resource "aws_acm_certificate_validation" "ecs_domain_certificate_validation" {
  certificate_arn         = aws_acm_certificate.ecs_domain_certificate.arn
  validation_record_fqdns = [for record in aws_route53_record.ecs_cert_validation_record : record.fqdn]
}