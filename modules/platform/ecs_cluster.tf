resource "aws_ecs_cluster" "fargate-cluster" {
    name = "fargate-cluster"
    # capacity_providers = ["FARGATE", "FARGATE_SPOT"]
    # default_capacity_provider_strategy {
    #     capacity_provider = "FARGATE"
    #     weight            = 1
    # }
    # default_capacity_provider_strategy {
    #     capacity_provider = "FARGATE_SPOT"
    #     weight            = 1
    # }
    # tags = {
    #     Name = "fargate-cluster"
    # }
  
}

resource "aws_alb" "ecs_cluster_alb" {
    name = "alb-${var.ecs_cluster_name}"
    internal = false
    security_groups = [aws_security_group.ecs_alb_security_group.id]
    subnets = [for subnet in aws_subnet.public : subnet.id]

    tags = {
        Name = "alb-${var.ecs_cluster_name}"
    }
}

resource "aws_alb_listener" "ecs_alb_https_listener" {
    load_balancer_arn = aws_alb.ecs_cluster_alb.arn
    port = 443
    protocol = "HTTPS"
    ssl_policy = "ELBSecurityPolicy-2016-08"
    certificate_arn = aws_acm_certificate.ecs_domain_certificate.arn

    default_action {
        type = "forward"
        target_group_arn = aws_alb_target_group.ecs_cluster_target_group.arn
    }

    depends_on  = [aws_alb_target_group.ecs_cluster_target_group]
}

resource "aws_alb_target_group" "ecs_cluster_target_group" {
    name = "target-group-${var.ecs_cluster_name}"
    port = 80
    protocol = "HTTP"
    vpc_id = data.terraform_remote_state.infrastructure.vpc_id

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

resource "aws_route53_record" "ecs_load_balancer_record" {
    name = "*.${var.ecs_domain_name}"
    type = "A"
    zone_id = data.aws_route53_zone.ecs_domain.zone_id

    alias {
        name = aws_alb.ecs_cluster_alb.dns_name
        zone_id = aws_alb.ecs_cluster_alb.zone_id
        evaluate_target_health = false
    }
}

resource "aws_iam_role" "ecs_cluster_role" {
    name               = "iam-role-${var.ecs_cluster_name}"
    assume_role_policy = file("ecs_role_policy.json")
}

resource "aws_iam_role_policy" "ecs_cluster_policy" {
    name   = "iam-policy-${var.ecs_cluster_name}"
    role   = aws_iam_role.ecs_cluster_role.id
    policy = file("ecs_cluster_policy.json")
}