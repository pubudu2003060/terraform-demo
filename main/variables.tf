variable "ami_value" {
  description = "value"
}

variable "instance_type_value" {
  description = "value"
  type = map(string)

  default = {
    "dev" = "t3.micro"
    "stage" = "t3.medium"
    "prod" = "t3.xlarge"
  }
}