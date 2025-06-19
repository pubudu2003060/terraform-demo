/*terraform {
  backend "s3" {
    bucket = "terraform-demo-s3-bucket-pubudu2003060"
    region = "eu-north-1"
    key = "pubudu/${terraform.workspace}/backend.tf"
   dynamodb_table = "terraform-lock"
  }
}*/