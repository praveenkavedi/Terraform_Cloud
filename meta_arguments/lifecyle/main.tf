#Learning Terraform - Life Cycle Meta Argument
    # create_before_destroy
    # prevent_destroy
    # ignore_changes


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
## create_before_destroy
 # prevent_destroy
resource "aws_vpc" "mum-vpc" {
  cidr_block       = "10.0.0.0/16"
  instance_tenancy = "default"
    lifecycle {
        create_before_destroy = true
    }

  tags = {
    Name = "mum-vpc"
  }
}
#testing ignore_changes
resource "aws_iam_user" "lb" {
  name = "loadbalancer"
  path = "/system/"
  lifecycle {
    ignore_changes = [tags]
  }
  tags = {
    name = "loadbalancer"
  }
}
