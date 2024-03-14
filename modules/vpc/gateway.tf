#Internet Gateway
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.vpc.id

  tags = {
    Name        = "${var.project_name}-vpc"
    Project     = var.project_name
    Environment = var.infrastructure_environment
    VPC         = aws_vpc.vpc.id
    ManagedBy   = "terraform"
  }
}