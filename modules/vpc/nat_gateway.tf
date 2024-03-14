
#Nat Gateway
resource "aws_eip" "nat" {
  domain = "vpc"

  lifecycle {
    # prevent_destroy = true
  }

  tags = {
    Name        = "${var.project_name}-eip"
    Project     = var.project_name
    Environment = var.infrastructure_environment
    VPC         = aws_vpc.vpc.id
    ManagedBy   = "terraform"
    Role        = "private"
  }
}

# Note: We're only creating one NAT Gateway, potential single point of failure
# Each NGW has a base cost per hour to run, roughly $32/mo per NGW. You'll often see
#  one NGW per AZ created, and sometimes one per subnet.
# Note: Cross-AZ bandwidth is an extra charge, so having a NAT per AZ could be cheaper
#        than a single NGW depending on your usage
resource "aws_nat_gateway" "ngw" {
  allocation_id = aws_eip.nat.id

  # Whichever the first public subnet happens to be
  # (because NGW needs to be on a public subnet with an IGW)
  # keys(): https://www.terraform.io/docs/configuration/functions/keys.html
  # element(): https://www.terraform.io/docs/configuration/functions/element.html
  subnet_id = aws_subnet.public[element(keys(aws_subnet.public), 0)].id

  tags = {
    Name        = "${var.project_name}-ngw"
    Project     = var.project_name
    VPC         = aws_vpc.vpc.id
    Environment = var.infrastructure_environment
    ManagedBy   = "terraform"
    Role        = "private"
  }
}
