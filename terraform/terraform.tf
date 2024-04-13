terraform {
    backend "s3" {
        bucket         = "github-actions-test-terraform-docker-ecr-ecs-fargate"
        key            = "fargate_test/terraform.tfstate"
        region         = "us-west-2"
        dynamodb_table = "github-actions-fargate-test-db"
        encrypt        = true
    }
}