# variable "route53_parent_zone_id" {
#     description = "The hosted zone name"
#     type        = string
# }

# variable "main_domain_name" {
#     description = "The domain name"
#     type        = string
# }

variable "sub_domain_name" {
    description = "The sub domain name"
    type        = string
}

variable "load_balancer_arn" {
    description = "The load balancer ARN"
    type        = string
}

variable "target_group_arn" {
    description = "The target group ARN"
    type        = string
}

variable "aws_lb_target_group_ecs_app_target_group_arn" {
    description = "The target group ARN"
    type        = string
}

variable "aws_lb_ecs_cluster_lb_dns_name" {
    description = "The load balancer DNS name"
    type        = string
}

variable "aws_lb_ecs_cluster_lb_zone_id" {
    description = "The load balancer zone ID"
    type        = string
}