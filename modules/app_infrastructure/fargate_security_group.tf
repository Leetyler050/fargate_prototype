resource "aws_security_group" "app_security_group" {
    name       =  "app-sg-${var.ecs_service_name}"
    description =  "Security group for app to traffic for ECS cluster"
    vpc_id = var.vpc_id

    ingress {
        from_port = 8080
        protocol = "TCP"
        to_port = 8080
        cidr_blocks = [var.vpc_cidr_blocks]
    }

    egress {
        from_port = 0
        protocol = "-1"
        to_port = 0
        cidr_blocks = ["0.0.0.0/0"] #var.vpc_cidr_blocks
    }

    tags = {
        Name = "app-sg-${var.ecs_service_name}"
    }
}