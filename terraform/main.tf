
#use the vpc module
module "infrastructure" {
  source                     = "../modules/infrastructure"
  aws_region                 = "us-west-2"
  project_name               = "github-actions-terraform-docker-ecr-ecs-fargate"
  infrastructure_environment = "development"
  public_subnet_map = {
                            "us-west-2a" = 1
                            "us-west-2b" = 2
                           }
  private_subnet_map = {
                                "us-west-2a" = 3
                                "us-west-2b" = 4
                            }
}

# module "platform" {
#   source                     = "../modules/platform"
#   aws_region                 = "us-west-2"
#   project_name               = "github-actions-terraform-docker-ecr-ecs-fargate"
#   infrastructure_environment = "development"
#   ecs_cluster_name           = "github-actions-terraform-docker-ecr-ecs-fargate"
# }
