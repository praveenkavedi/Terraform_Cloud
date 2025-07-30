terraform {
  required_version = "~> 1.12.0"
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "~> 4.0"
    }
  }
}
#default-mumbai provider
provider "aws" {
  region = "ap-south-1"
}

resource "aws_vpc" "mum-vpc" {
  cidr_block       = "10.0.0.0/16"
  instance_tenancy = "default"
  count = 2

  tags = {
    Name = "mum-vpc- ${count.index}"
  }
}

