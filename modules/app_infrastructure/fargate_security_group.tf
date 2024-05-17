# resource "aws_security_group" "lb_security_group" {
#     name       =  "app-sg-${var.ecs_service_name}"
#     description =  "Security group for app to traffic for ECS cluster"
#     vpc_id = var.vpc_id

#     ingress {
#         from_port = 8050
#         protocol = "TCP"
#         to_port = 8050
#         cidr_blocks = [var.vpc_cidr_blocks]
#     }

#     egress {
#         from_port = 0
#         protocol = "-1"
#         to_port = 0
#         cidr_blocks = ["0.0.0.0/0"] #var.vpc_cidr_blocks
#     }

#     tags = {
#         Name = "app-sg-${var.ecs_service_name}"
#     }
# }

resource "aws_security_group" "ecs_security_group" {
    name       =  "ecs-sg-${var.ecs_service_name}"
    description =  "Security group for ECS cluster"
    vpc_id = var.vpc_id

    ingress {
        from_port = 8050
        protocol = "-1"
        to_port = 0
        cidr_blocks = [var.vpc_cidr_blocks]
        #security_groups = [aws_security_group.lb_security_group.id]
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