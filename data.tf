terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.17.0"
    }
  }
}
provider "aws" {
  region     = "ap-south-1"
  access_key = "AKM6"
  secret_key = "1"
}
#### find form ID "default = true " # find form name use filters
data "aws_vpc" "myvpc" {
  filter {
    name   = "tag:Name"
    values = ["dev-vpc"] ### find form name
  }
}

output "my_defult_vpc" {
  value = data.aws_vpc.myvpc.id
}


resource "aws_subnet" "mysubnet" {
  vpc_id     = data.aws_vpc.myvpc.id
  cidr_block = "10.0.1.0/24"

  tags = {
    Name = "dev-subnet"
  }
}
##### instance 
resource "aws_instance" "web" {
  ami           = "ami-05552d2dcf89c9b24"
  instance_type = "t2.micro"
  subnet_id     = aws_subnet.mysubnet.id

  tags = {
    Name = "dev-subnet"
  }
}
