resource "aws_ssm_parameter" "ssm_test" {
    name  = "/test/ssm_test2"
    type  = "String"
    value = "This is to see if things work again???"
    description = "This is a oidc test"
    tags = {
        Name = "test"
    }
}