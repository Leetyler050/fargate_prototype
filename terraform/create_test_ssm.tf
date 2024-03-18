resource "aws_ssm_parameter" "ssm_test" {
    name  = "/test/ssm_test"
    type  = "String"
    value = "This is a test SSM parameter"
    description = "This is a test SSM parameter"
    tags = {
        Name = "test"
    }
}