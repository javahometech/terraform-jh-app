variable "region" {
  default = "us-west-2"
}

variable "vpc_cidr" {
  default = "192.168.0.0/16"
}

# Subnets for the VPC
variable "azs" {
  type    = "list"
  default = ["us-west-2a", "us-west-2b"]
}

variable "subnets_cidr" {
  type    = "list"
  default = ["192.168.1.0/24", "192.168.2.0/24"]
}

variable "ami" {
  default = "ami-e689729e"
}

variable "instance_type" {
  default = "t2.micro"
}

variable "ec2_key" {
  default = "hari-demo"
}
