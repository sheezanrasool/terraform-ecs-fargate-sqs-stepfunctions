# terraform {
#   backend "s3" {
#     bucket = "ar-terraform-infra-12"
#     region = "us-east-1"
#     dynamodb_table = "AR-terraform-locks"
#     key = "terraform.tfstate"
#   }
# }