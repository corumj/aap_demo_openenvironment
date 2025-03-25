terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.84.0"
    }
  }
  backend "s3" {}
}

provider "aws" {
  region = "us-east-1"
}

# Fetch the default VPC
# data "aws_vpc" "ansible-vpc" {
#   default = true
# }
resource "aws_vpc" "ansible-vpc" {
  cidr_block       = "10.0.0.0/16"
  instance_tenancy = "default"

  tags = {
    Name = "ansible"
  }
}

resource "aws_instance" "tf-demo-aws-ec2-instance-1" {
  ami           = "ami-0005e0cfe09cc9050"
  instance_type = "t2.micro"
  tags = {
    Name = "tf-demo-aws-ec2-instance-1"
  }

}