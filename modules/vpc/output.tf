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

 output "aws_security_group_eks_cluster_id" {
    value       = aws_security_group.eks_cluster.id
    description = "Name of the EKS cluster"
}
