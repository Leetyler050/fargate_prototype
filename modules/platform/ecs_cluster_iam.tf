resource "aws_iam_role" "ecs_cluster_role" {
    name               = "iam-role-${var.ecs_cluster_name}"
    assume_role_policy = file("${path.module}/ecs_role_policy.json")
}

resource "aws_iam_role_policy" "ecs_cluster_policy" {
    name   = "iam-policy-${var.ecs_cluster_name}"
    role   = aws_iam_role.ecs_cluster_role.id
    policy = file("${path.module}/ecs_cluster_policy.json")
}