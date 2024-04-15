#Internet Gateway
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.vpc.id

  tags = {
    Name        = "igw-${var.project_name}"
    Project     = var.project_name
    Environment = var.infrastructure_environment
    VPC         = aws_vpc.vpc.id
    ManagedBy   = "terraform"
    Description = "Internet Gateway for ${var.project_name}"
  }
}