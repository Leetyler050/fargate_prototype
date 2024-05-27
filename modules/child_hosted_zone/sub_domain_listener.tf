#Creates a listener for the sub domain for the load balancer
resource "aws_lb_listener" "sub_domain_ecs_lb_https_listener" {
    load_balancer_arn = var.load_balancer_arn
    port = 8443
    protocol = "HTTPS"
    ssl_policy = "ELBSecurityPolicy-TLS13-1-2-2021-06"
    certificate_arn = aws_acm_certificate.sub_domain_certificate.arn

    default_action {
        type = "forward"
        target_group_arn = var.load_balancer_target_group_arn
    }
}

##listener rule
resource "aws_lb_listener_rule" "ecs_lb_listener_rule" {
    listener_arn = aws_lb_listener.sub_domain_ecs_lb_https_listener.arn

    action {
        type             = "forward"
        target_group_arn = var.aws_lb_target_group_ecs_app_target_group_arn
    }
    condition {
        host_header {
            values = ["sub_domain_test.${var.sub_domain_name}"]
    }
    }
}