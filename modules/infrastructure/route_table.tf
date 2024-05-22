
###
# Route Tables, Routes and Associations
##
# Public Route Table (Subnets with IGW)
resource "aws_route_table" "public_rt" {
  vpc_id = aws_vpc.vpc.id

  tags = {
    Name        = "public-route-table-${var.project_name}"
    Environment = var.infrastructure_environment
    Project     = var.project_name
    Role        = "public"
    VPC         = aws_vpc.vpc.id
    ManagedBy   = "terraform"
    Description = "Public Route Table for Public Subnets"
  }
}

# Private Route Tables (Subnets with NGW)
resource "aws_route_table" "private_rt" {
  vpc_id = aws_vpc.vpc.id

  tags = {
    Name        = "private-route-table-${var.project_name}"
    Environment = var.infrastructure_environment
    Project     = var.project_name
    Role        = "private"
    VPC         = aws_vpc.vpc.id
    ManagedBy   = "terraform"
    Description = "Private Route Table for Private Subnets"
  }
}

# Public Route
resource "aws_route" "public_route" {
  route_table_id         = aws_route_table.public_rt.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.igw.id
}

# Private Route
resource "aws_route" "private_route" {
  route_table_id         = aws_route_table.private_rt.id
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id         = aws_nat_gateway.ngw.id
}

# Public Route to Public Route Table for Public Subnets
resource "aws_route_table_association" "public" {
  for_each  = aws_subnet.public
  subnet_id = aws_subnet.public[each.key].id

  route_table_id = aws_route_table.public_rt.id
}

# Private Route to Private Route Table for Private Subnets
resource "aws_route_table_association" "private" {
  for_each  = aws_subnet.private
  subnet_id = aws_subnet.private[each.key].id

  route_table_id = aws_route_table.private_rt.id
}
