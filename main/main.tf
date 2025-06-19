provider "aws" {
  region = "eu-north-1"
}

# module "ec2_instance" {
#   source = "./modules/ec2_instance"
#   ami_value = var.ami_value
#   instance_type_value = lookup(var.instance_type_value,terraform.workspace,"t2.micro")
# }

module "aws_s3_bucket" {
  source = "./modules/s3"
}

module "aws_dynamodb_table" {
 source="./modules/dynomo_db" 
}