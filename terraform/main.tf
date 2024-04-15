# module "vpc" {
#     source = "../modules/vpc"
#     project_name = "github_actions_terraform_docker_ecr_ecs_fargate"
#     region_aws = "us-west-2"
#     s3_bucket_name = "github-actions-test-terraform-docker-ecr-ecs-fargate"
#     dynamodb_name = "github-actions-fargate-test-db"
# }

#use the vpc module
module "vpc" {
  source                     = "../modules/vpc"
  aws_region                 = "us-west-2"
  project_name               = "github-actions-terraform-docker-ecr-ecs-fargate"
  infrastructure_environment = "development"
  public_subnet_numbers = {
                            "us-west-2a" = 1
                            "us-west-2b" = 2
                           }
  private_subnet_numbers = {
                                "us-west-2a" = 3
                                "us-west-2b" = 4
                            }
}

