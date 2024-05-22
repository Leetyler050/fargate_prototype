resource "aws_security_group" "ecs_lb_security_group" {
  name        =  "alb-sg-${var.ecs_cluster_name}"
  description =  "Security group for ALB to traffic for ECS cluster"
  vpc_id      =  var.vpc_id


    ingress {
        from_port   = 443 #80
        to_port     = 443 #80
        protocol    = "TCP"
        cidr_blocks = [var.internet_cidr_blocks]
    }

    egress {
        from_port   = 0
        to_port     = 0
        protocol    = "-1"
        cidr_blocks = [var.internet_cidr_blocks]
    }

}