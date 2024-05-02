resource "aws_ecs_service" "ecs_service" {
    name            = var.ecs_service_name
    task_definition = var.ecs_service_name
    desired_count   = var.desired_task_number
    cluster        = var.ecs_cluster_name
    launch_type     = "FARGATE"

    network_configuration {
        subnets          = var.public_subnet_set #might need to be in the private subnet
        security_groups  = [aws_security_group.app_security_group.id]
        assign_public_ip = true
    }

    load_balancer {
      container_name = ecs_service_name
      container_port = var.docker_container_port
      target_group_arn = aws_lb_target_group.ecs_app_target_group.arn
    }
}