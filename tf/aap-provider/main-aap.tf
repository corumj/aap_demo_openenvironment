terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.84.0"
    }

    aap = {
      source = "ansible/aap"
    }
  }
	backend "s3" {}
}

provider "aws" {
  region = "us-east-2"
}

resource "aws_vpc" "aap_vpc" {
  cidr_block = "172.16.0.0/16"

  tags = {
    Name = "tf-example"
  }
}

resource "aws_subnet" "aap_subnet" {
  vpc_id            = aws_vpc.aap_vpc.id
  cidr_block        = "172.16.10.0/24"

  tags = {
    Name = "tf-example"
  }
}

resource "aws_network_interface" "foo2" {
  subnet_id   = aws_subnet.aap_subnet.id
  private_ips = ["172.16.10.100"]

  tags = {
    Name = "primary_network_interface2"
  }
}

resource "aws_instance" "tf-demo-aws-ec2-instance-2" {
  ami           = "ami-0005e0cfe09cc9050"
  instance_type = "t2.micro"
  tags = {
    Name = "tf-demo-aws-ec2-instance-2"
  }
  network_interface {
    network_interface_id = aws_network_interface.foo2.id
    device_index         = 0
  }

  credit_specification {
    cpu_credits = "unlimited"
  }

  }
}

provider "aap" {
  host     = "https://gateway.sandbox3281.opentlc.com/"
  username = "admin"
  password = "Ry3h0m3bus"
  insecure_skip_verify = true
}

resource "aap_host" "tf-demo-aws-ec2-instance-2" {
  inventory_id = 2
  name = "aws_instance_tf-demo-aws-ec2-instance-2"
  description = "An EC2 instance created by Terraform"
  variables = jsonencode(aws_instance.tf-demo-aws-ec2-instance-2)
}