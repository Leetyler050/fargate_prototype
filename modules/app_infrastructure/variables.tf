#application variables for task

variable "ecs_service_name" {
  description = "The name of the ECS service"
  type        = string
}

variable "docker_image_url" {
  description = "the url of the docker image maybe ecr?"
  type        = string
}

variable "memory" {
  description = "The amount of memory to allocate to the container"
  type        = string
}

variable "docker_container_port" {
  description = "The port the container listens on"
  type        = number
}

variable environment {
  description = "The environment variables to pass to the container"
  type        = string
}

variable region {
  description = "The region to deploy the ECS service"
  type        = string
}

variable vpc_id {
  description = "The VPC to deploy the ECS service"
  type        = string
}

variable "vpc_cidr_blocks" {
    description = "The CIDR blocks to allow traffic from"
    type        = string
}

variable "desired_task_number" {
    description = "The number of tasks to run"
    type        = number
}

variable "ecs_cluster_name" {
    description = "The name of the ECS cluster"
    type        = string
}

variable "public_subnet_set" {
    description = "The public subnets to deploy the ECS service"
    type        = set(string)
}

variable "ecs_aws_lb_listener_arn" {
    description = "The name of the load balancer"
    type        = string
}

variable "domain_name" {
    description = "The domain name to use"
    type        = string
}

variable "ecr_repo_name" {
    description = "The name of the ECR repository"
    type        = string
}

variable project_name {
    description = "The name of the project"
    type        = string
}