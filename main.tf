provider "aws" {
  region = "eu-north-1"
}

resource "aws_instance" "name" {
  ami = "ami-042b4708b1d05f512"
  instance_type = "t3.micro"
  subnet_id = "subnet-0b1c2d3e4f5g6h7i8"
  tags = {
    Name = "MyInstance"
  }
}

# module "ec2_instance" {
#   source = "./modules/ec2_instance"
#   ami_value = "ami-042b4708b1d05f512"
#   instance_type_value = "t3.micro"
# }

/*module "aws_s3_bucket" {
  source = "./modules/s3"
}

module "aws_dynamodb_table" {
 source="./modules/dynomo_db" 
}*/