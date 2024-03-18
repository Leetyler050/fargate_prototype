provider "aws" {
  region     = var.region_aws
}

resource "aws_s3_bucket" "s3_bucket" {
    
    bucket = var.s3_bucket_name
    tags = {
        Description = "${var.project_name} Terraform state file"
    }
}