variable "route53_parent_zone_id" {
    description = "The hosted zone name"
    type        = string
}

variable "sub_domain" {
    description = "The sub domain name"
    type        = string
}

variable "main_domain_name" {
    description = "The domain name"
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