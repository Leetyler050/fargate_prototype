data "template_file" "ecs_task_definition_template" {
    template = file("${path.module}/ecs_task_definition.json")
    vars = {
        task_definition_name = var.ecs_service_name
        ecs_service_name = var.ecs_service_name
        ecs_cluster_name = var.docker_image_url
        memory = var.memory
        docker_container_port = var.docker_container_port
        environment = var.environment
        region = var.region
    }
}

resource "aws_ecs_task_definition" "ecs_task_definition" {
    family                   = var.ecs_service_name
    container_definitions    = data.template_file.ecs_task_definition_template.rendered
    requires_compatibilities = ["FARGATE"]
    network_mode             = "awsvpc"
    cpu                      = 512
    memory                   = var.memory
    execution_role_arn       = aws_iam_role.fargate_iam_role.arn
    task_role_arn            = aws_iam_role.fargate_iam_role.arn
}

