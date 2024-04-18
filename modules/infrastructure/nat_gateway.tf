
#Nat Gateway
resource "aws_eip" "nat_eip" {
  domain = "vpc"
  associate_with_private_ip = "10.0.0.5"

  lifecycle {
    # prevent_destroy = true
  }

  tags = {
    Name        = "nat-elastic-ip-${var.project_name}"
    Project     = var.project_name
    Environment = var.infrastructure_environment
    VPC         = aws_vpc.vpc.id
    ManagedBy   = "terraform"
    Role        = "private"
    Description = "Elastic IP for Network Address Translation Gateway"
  }
}

# Note: We're only creating one NAT Gateway, potential single point of failure
# Each NGW has a base cost per hour to run, roughly $32/mo per NGW. You'll often see
#  one NGW per AZ created, and sometimes one per subnet.
# Note: Cross-AZ bandwidth is an extra charge, so having a NAT per AZ could be cheaper
#        than a single NGW depending on your usage
resource "aws_nat_gateway" "ngw" {
  allocation_id = aws_eip.nat_eip.id

  # Whichever the first public subnet happens to be
  # (because NGW needs to be on a public subnet with an IGW)
  # keys(): https://www.terraform.io/docs/configuration/functions/keys.html
  # element(): https://www.terraform.io/docs/configuration/functions/element.html
  subnet_id = aws_subnet.public[element(keys(aws_subnet.public), 0)].id

  tags = {
    Name        = "nat-gateway-${var.project_name}"
    Project     = var.project_name
    VPC         = aws_vpc.vpc.id
    Environment = var.infrastructure_environment
    ManagedBy   = "terraform"
    Role        = "private"
    Description = "Network Address Translation Gateway for ${var.project_name}"
  }
  depends_on = [aws_eip.nat_eip]
}
