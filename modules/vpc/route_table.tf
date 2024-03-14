
###
# Route Tables, Routes and Associations
##

# Public Route Table (Subnets with IGW)
resource "aws_route_table" "public" {
  vpc_id = aws_vpc.vpc.id

  tags = {
    Name        = "${var.project_name}-public-rt"
    Environment = var.infrastructure_environment
    Project     = var.project_name
    Role        = "public"
    VPC         = aws_vpc.vpc.id
    ManagedBy   = "terraform"
  }
}

# Private Route Tables (Subnets with NGW)
resource "aws_route_table" "private" {
  vpc_id = aws_vpc.vpc.id

  tags = {
    Name        = "${var.project_name}-private-rt"
    Environment = var.infrastructure_environment
    Project     = var.project_name
    Role        = "private"
    VPC         = aws_vpc.vpc.id
    ManagedBy   = "terraform"
  }
}


# Public Route
resource "aws_route" "public" {
  route_table_id         = aws_route_table.public.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.igw.id
}

# Private Route
resource "aws_route" "private" {
  route_table_id         = aws_route_table.private.id
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id         = aws_nat_gateway.ngw.id
}

# Public Route to Public Route Table for Public Subnets
resource "aws_route_table_association" "public" {
  for_each  = aws_subnet.public
  subnet_id = aws_subnet.public[each.key].id

  route_table_id = aws_route_table.public.id
}

# Private Route to Private Route Table for Private Subnets
resource "aws_route_table_association" "private" {
  for_each  = aws_subnet.private
  subnet_id = aws_subnet.private[each.key].id

  route_table_id = aws_route_table.private.id
}

# Create security group for EKS cluster
resource "aws_security_group" "eks_cluster" {
  vpc_id = aws_vpc.vpc.id

}