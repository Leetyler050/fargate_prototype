resource "aws_cloudwatch_log_group" "ecs_log_group" {
  name = "LogGroup-${var.ecs_service_name}"
}