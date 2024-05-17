
#use the infrastructure module
module "infrastructure" {
  source                     = "../modules/infrastructure"
  vpc_cidr                   = "10.0.0.0/17"
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
module "app_infra" {
  source = "../modules/app_infrastructure"
  ecs_service_name = "fargate-test"
  docker_container_port = 8080
  memory = 512
  environment = "development"
  vpc_id = module.infrastructure.vpc_id
  vpc_cidr_blocks = module.infrastructure.vpc_cidr
  desired_task_number = 1
  ecs_cluster_name = module.platform.ecs_cluster_name
  public_subnet_set = module.infrastructure.public_subnets
  private_subnet_set = module.infrastructure.private_subnets
  ecs_aws_lb_listener_arn = module.platform.ecs_lb_listener_arn
  domain_name = module.platform.domain_name
  ecr_repo_name = "ecr-fargate_test"
  project_name = "fargate_test"
}