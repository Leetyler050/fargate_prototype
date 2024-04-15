
# Create 1 public subnets for each AZ within the regional VPC
resource "aws_subnet" "public" {
  for_each = var.public_subnet_numbers
  vpc_id = aws_vpc.vpc.id
  map_public_ip_on_launch = "true"
  availability_zone       = each.key

  # 2,048 IP addresses each
  cidr_block = cidrsubnet(aws_vpc.vpc.cidr_block, 4, each.value)

  tags = {
    Name        = "public-subnet-${each.value}-${var.project_name}"
    Project     = var.project_name
    Role        = "public"
    Environment = var.infrastructure_environment
    ManagedBy   = "terraform"
    Subnet      = "${each.key}-${each.value}"
    Description = "Public Subnet for ${each.key}-${each.value}"
  }
}

# Create 1 private subnets for each AZ within the regional VPC
resource "aws_subnet" "private" {
  for_each = var.private_subnet_numbers

  vpc_id                  = aws_vpc.vpc.id
  map_public_ip_on_launch = "false"
  availability_zone       = each.key

  # 2,048 IP addresses each
  cidr_block = cidrsubnet(aws_vpc.vpc.cidr_block, 4, each.value)

  tags = {
    Name        = "private-subnet-${each.value}-${var.project_name}"
    Project     = var.project_name
    Role        = "private"
    Environment = var.infrastructure_environment
    ManagedBy   = "terraform"
    Subnet      = "${each.key}-${each.value}"
    Description = "Private Subnet for ${each.key}-${each.value}"
  }
}