resource "aws_lb_target_group" "ecs_app_target_group" {
    name        = "fargate-tg-${var.ecs_service_name}"
    port        = var.docker_container_port
    protocol    = "HTTP"
    vpc_id      = var.vpc_id
    target_type = "ip"

    health_check {
        path                = "/actuator/health"
        protocol            = "HTTP"
        matcher             = "200" 
        port                = "traffic-port"
        interval            = 60
        timeout             = 30
        healthy_threshold   = 3
        unhealthy_threshold = 3
    }
    tags = {
        Name = "fargate-tg-${var.ecs_service_name}"
    }
}

#removed listener rule to update target group
# resource "aws_lb_listener_rule" "ecs_lb_listener_rule" {
#     listener_arn = var.ecs_aws_lb_listener_arn

#     action {
#         type             = "forward"
#         target_group_arn = aws_lb_target_group.ecs_app_target_group.arn
#     }
#     condition {
#         host_header {
#             values = ["${lower(var.ecs_service_name)}.${var.domain_name}"]
#     }
#     }
# }




# resource "aws_lb_listener" "ecs_lb_listener_rule" {
#     load_balancer_arn = aws_lb.app_lb.arn

#     port = 80
#     protocol = "HTTP"
#     default_action {
#         type = "forward"
#         target_group_arn = aws_lb_target_group.ecs_app_target_group.arn
#     }

# }

# resource "aws_lb" "app_lb" {
#     name               = "fargate-lb-${var.ecs_service_name}"
#     internal           = false
#     load_balancer_type = "application"
#     security_groups    = [aws_security_group.lb_security_group.id]
#     subnets            = var.public_subnet_set

#     enable_deletion_protection = false

#     tags = {
#         Name = "fargate-lb-${var.ecs_service_name}"
#     }
# }