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

resource "aws_route53_record" "ecs_load_balancer_record" {
    name = "*.${var.domain_name}"
    type = "A"
    zone_id = data.aws_route53_zone.ecs_domain.zone_id

    alias {
        name = aws_alb.ecs_cluster_alb.dns_name
        zone_id = aws_alb.ecs_cluster_alb.zone_id
        evaluate_target_health = false
    }
}