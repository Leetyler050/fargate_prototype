# resource "aws_route53_zone" "test" {
#   name = var.sub_domain

#   tags = {
#     Environment = "test"
#   }
# }

# resource "aws_route53_record" "test_ns" {
#   zone_id = var.route53_parent_zone_id
#   name    = var.sub_domain
#   type    = "NS"
#   ttl     = "360"
#   records = aws_route53_zone.test.name_servers
# }