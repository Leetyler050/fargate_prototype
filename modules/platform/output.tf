# output "ecs_lb_listener_arn" {
#   value = aws_lb_listener.ecs_lb_https_listener.arn
# }

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

output "ecslb_target_group_arn" {
    value = aws_lb_target_group.ecs_cluster_target_group.arn
}

# output "ecs_cluster_lb_arn" {
#     value = aws_lb.app_lb.arn
# }