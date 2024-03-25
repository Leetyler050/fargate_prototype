resource "aws_ssm_parameter" "ssm_test" {
    name  = "/test/ssm_test"
    type  = "String"
    value = "This is oidc test value"
    description = "This is a oidc test"
    tags = {
        Name = "test"
    }
}