# variable "aws_region" {
#  default="us-west-2"
# }

# variable "remote_state_bucket" {
# #  default="github-actions-test-terraform-docker-ecr-ecs-fargate"
# }

# variable "remote_state_key" {
# #  default="fargate_test/terraform.tfstate"
# }

variable "ecs_cluster_name" {
    type = string
#   default="github-actions-terraform-docker-ecr-ecs-fargate"
}

variable "internet_cidr_blocks" {
    type = string
#   default=[" 
}

variable "domain_name" {
    type = string
}

variable "vpc_id" {
    type = string
}

variable "public_subnet_set" {
    type = set(string)
}

