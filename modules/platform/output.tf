output "ecs_lb_listener_arn" {
  value = aws_lb_listener.ecs_lb_https_listener.arn
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

output "ecslb_target_group_arn" {
    value = aws_lb_target_group.ecs_cluster_target_group.arn
}

output "route_53_main_zone_id" {
    value = aws_route53_zone.ecs_domain.id
}

output "load_balancer_arn" {
    value = aws_lb.ecs_cluster_lb.arn
}

output "aws_lb_target_group_ecs_cluster_target_group_arn" {
    value = aws_lb_target_group.ecs_cluster_target_group.arn
}

output "aws_lb_ecs_cluster_lb_dns_name" {
    value = aws_lb.ecs_cluster_lb.dns_name
}

output "aws_lb_ecs_cluster_lb_zone_id" {
    value = aws_lb.ecs_cluster_lb.zone_id
}