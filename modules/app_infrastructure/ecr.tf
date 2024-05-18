resource "aws_ecr_repository" "app_ecr" {
  name = var.ecr_repo_name
  image_tag_mutability = "MUTABLE"
  force_delete = true
  image_scanning_configuration {
    scan_on_push = true
  }
  encryption_configuration {
    encryption_type = "KMS"
  }
  tags = {
    Name = var.ecr_repo_name
  }
}

