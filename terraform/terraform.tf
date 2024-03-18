terraform {
    backend "s3" {
        bucket         = "github-actions-test-s3-bucket"
        key            = "terraform.tfstate"
        region         = "us-west-2"
        dynamodb_table = "github-actions-test-db"
        encrypt        = true
    }
}