variable "ami_value" {
  description = "value for the ami"
  type = string
}

variable "instance_type_value" {
  description = "value for instance type"
}

variable "cidr_block_value" {
  description = "value for the cidr block"
  type = string
  default = "10.0.0.0/16"
}

