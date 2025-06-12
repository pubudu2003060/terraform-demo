provider "aws" {
  region = "eu-north-1"
}

resource "aws_s3_bucket" "s3_bucket" {
  bucket = "terraform-demo-s3-bucket-pubudu2003060"
}