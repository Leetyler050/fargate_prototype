# provider "aws" {
#     region = var.aws_region
    
# }

# terraform {
#     backend "s3" {
#         # bucket = var.state_bucket
#         # key = "fargate_test/terraform.tfstate"
#         # region = var.aws_region
#         # dynamodb_table = var.dynamodb_name
#         # encrypt = true
#     }
# }

# data "terraform_remote_state" "infrastructure" {
#     backend = "s3"
    
#     config = {
#         region = var.aws_region
#         bucket = var.remote_state_bucket
#         key = var.remote_state_key
#     }
# }