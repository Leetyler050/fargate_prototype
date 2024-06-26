resource "aws_lb" "ecs_cluster_lb" {
    name            = "lb-${var.ecs_cluster_name}"
    internal        = false
    security_groups = [aws_security_group.ecs_lb_security_group.id]
    #subnets = [for subnet in aws_subnet.public : subnet.id]
    subnets         = var.public_subnet_set

    tags = {
        Name = "lb-${var.ecs_cluster_name}"
    }
}

resource "aws_lb_listener" "ecs_lb_https_listener" {
    load_balancer_arn = aws_lb.ecs_cluster_lb.arn
    port = 443
    protocol = "HTTPS"
    ssl_policy = "ELBSecurityPolicy-TLS13-1-2-2021-06"
    certificate_arn = aws_acm_certificate.ecs_domain_certificate.arn

    default_action {
        type = "forward"
        target_group_arn = aws_lb_target_group.ecs_cluster_target_group.arn
    }

    depends_on  = [aws_lb_target_group.ecs_cluster_target_group]
}

resource "aws_lb_target_group" "ecs_cluster_target_group" {
    name = "tg-${var.ecs_cluster_name}"
    port = 80
    protocol = "HTTP"
    vpc_id = var.vpc_id
    # vpc_id = data.terraform_remote_state.infrastructure.vpc_id

    # health_check {
    #     path = "/"
    #     protocol = "HTTP"
    #     port = "traffic-port"
    #     interval = 30
    #     timeout = 5
    #     healthy_threshold = 2
    #     unhealthy_threshold = 2
    # }

    tags = {
        Name = "target-group-${var.ecs_cluster_name}"
    }
}