
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

module "platform" {
  source                     = "../modules/platform"
  ecs_cluster_name           = "git-act-terra-dock-ecr-ecs-far"
  vpc_id                     = module.infrastructure.vpc_id
  internet_cidr_blocks       = "0.0.0.0/0"#module.infrastructure.vpc_cidr
  domain_name                = "leetyler050.com"
  public_subnet_set          = module.infrastructure.public_subnets
}
