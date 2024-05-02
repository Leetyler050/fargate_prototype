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