resource "aws_dynamodb_table" "dynamodb-terraform-state-lock" {
  name = var.dynamodb_name
  hash_key = "LockID"
  read_capacity = 20
  write_capacity = 20
 
  attribute {
    name = "LockID"
    type = "S"
  }
  tags = {
    Description = "${var.project_name} Terraform state lock"
  }
}