provider "aws" {
  region = "eu-north-1"
}


module "aws_s3_bucket" {
  source = "../main/modules/s3"
}

module "aws_dynamodb_table" {
 source="../modules/dynomo_db" 
}