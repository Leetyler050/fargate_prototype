resource "aws_ecs_cluster" "fargate-cluster" {
    name = "fargate-cluster"
    # capacity_providers = ["FARGATE", "FARGATE_SPOT"]
    # default_capacity_provider_strategy {
    #     capacity_provider = "FARGATE"
    #     weight            = 1
    # }
    # default_capacity_provider_strategy {
    #     capacity_provider = "FARGATE_SPOT"
    #     weight            = 1
    # }
    # tags = {
    #     Name = "fargate-cluster"
    # }
  
}