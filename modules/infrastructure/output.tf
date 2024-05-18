output "public_subnets" {
  value = toset([
    for public in aws_subnet.public : public.id
  ])
}

output "private_subnets" {
  value = toset([
    for private in aws_subnet.private : private.id
  ])
}

output "vpc_id" {
  value = aws_vpc.vpc.id
}

output "vpc_cidr" {
  value = aws_vpc.vpc.cidr_block 
}
