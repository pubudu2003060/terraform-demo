terraform {
  backend "s3" {
    bucket = "terraform-demo-s3-bucket-pubudu2003060"
    region = "eu-north-1"
    key = "pubudu/terraform.tfstate"
   dynamodb_table = "terraform-lock"
  }
}