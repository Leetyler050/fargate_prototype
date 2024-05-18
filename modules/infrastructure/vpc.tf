# Create a VPC for the region associated with the AZ
resource "aws_vpc" "vpc" {
  cidr_block           = var.vpc_cidr
  enable_dns_support   = "true"
  enable_dns_hostnames = "true"

  tags = {
    Name        = "vpc-${var.project_name}"
    Project     = var.project_name
    Environment = var.infrastructure_environment
    ManagedBy   = "terraform"
    description = "Virtual Private Cloud for ${var.project_name}"
  }
}