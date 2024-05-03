
#use the infrastructure module
module "infrastructure" {
  source                     = "../modules/infrastructure"
  vpc_cidr                   = "10.0.0.0/19"
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

#use the platform module
module "platform" {
  source                     = "../modules/platform"
  ecs_cluster_name           = "git-act-ter-dock-ecr-ecs-far"
  vpc_id                     = module.infrastructure.vpc_id
  internet_cidr_blocks       = "0.0.0.0/0"#module.infrastructure.vpc_cidr
  domain_name                = "leetyler050.com"
  public_subnet_set          = module.infrastructure.public_subnets
}

#use the app_infrastructure module
# module "app_infrastructure" {
#   source                     = "../modules/app_infrastructure"
#   ecs_service_name           = "github-actions-terraform-docker-ecr-ecs-fargate"
#   docker_image_url           = "leetyler050.com/github-actions-terraform-docker-ecr-ecs-fargate"
#   memory                     = "512"
#   docker_container_port      = 80
#   environment                = "development"
#   region                     = "us-west-2"
#   vpc_id                     = module.infrastructure.vpc_id
#   vpc_cidr_blocks            = module.infrastructure.vpc_cidr
#   desired_task_number        = 1
#   ecs_cluster_name           = module.platform.ecs_cluster_name
#   public_subnet_set          = module.infrastructure.public_subnets
# }