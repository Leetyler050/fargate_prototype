variable "region_aws" {
    type = string
    default = "us-west-2"
}

variable "s3_bucket_name" {
    type = string
    default = "insert_name_of_your_s3_bucket"
}

variable "dynamodb_name" {
    type = string
    default = "insert_name_of_your_dynamodb_table"
}

variable  "project_name" {
    type = string
    default = "insert_name_of_your_project"
}