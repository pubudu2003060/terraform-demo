provider "aws" {
  region = "uu-north-1"
}

module "ec2_instance" {
  source = "./modules/ec2_instance"
  ami_value = "ami-042b4708b1d05f512"
  instance_type_value = "t3.micro"
  subnet_id_value = "subnet-048e15962efdc8543"
}

module "aws_s3_bucket" {
  source = "./modules/s3"
}

module "aws_dynamodb_table" {
 source="./modules/dynomo_db" 
}