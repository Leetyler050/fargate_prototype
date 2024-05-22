variable "ecs_cluster_name" {
    type = string
#   default="github-actions-terraform-docker-ecr-ecs-fargate"
}

variable "internet_cidr_blocks" {
    type = string
#   default=[" 
}

# variable "domain_name" {
#     type = string
# }   

variable "vpc_id" {
    type = string
}

variable "public_subnet_set" {
    type = set(string)
}

variable "docker_container_port" {
    type = number
}