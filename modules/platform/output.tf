output "ecs_alb_listener_arn" {
  value = aws_alb_listener.ecs_alb_https_listener.arn
}

output "ecs_cluster_name" {
    value = aws_ecs_cluster.fargate-cluster.name
}

output "ecs_cluster_role_name" {
    value = aws_iam_role.ecs_cluster_role.name
}

output "ecs_cluster_role_arn" {
    value = aws_iam_role.ecs_cluster_role.arn
}

output "domain_name" {
    value = var.domain_name
}
