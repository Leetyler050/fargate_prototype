resource "aws_iam_role" "fargate_iam_role" {
    name = "iam-role-${var.ecs_service_name}"
    assume_role_policy = file("${path.module}/fargate_role_policy.json")
}

resource "aws_iam_role_policy" "fargate_iam_role" {
    name = "iam-role-policy-${var.ecs_service_name}"
    role = aws_iam_role.fargate_iam_role.id
    policy = file("${path.module}/fargate_policy.json")
}