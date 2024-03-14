variable "vpc_cidr" {
  type        = string
  description = "The IP range to use for the VPC"
  default     = "10.0.0.0/16"
}

variable "infrastructure_environment" {
  type        = string
  description = "infrastructure environment"
  default     = "development_environment" #added in to make work
}

variable "project_name" {
  type        = string
  description = "Project Name"
  default     = "project_placeholder_name" #added in to make work
}

variable "aws_region" {
    type = string
    description = "sets a region west as default"
    default = "us-west-2"
}

variable "public_subnet_numbers" {
  type = map(number)

  description = "Map of AZ to a number that should be used for public subnets"

  default = {
    "us-west-2a" = 1
    "us-west-2b" = 2
  }
}

variable "private_subnet_numbers" {
  type = map(number)

  description = "Map of AZ to a number that should be used for private subnets"

  default = {
    "us-west-2a" = 3
    "us-west-2b" = 4
  }
}

