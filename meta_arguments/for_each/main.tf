#create three S3 buckets using for_each - map
#to create three differnt users using IAM, then we just need to pass list of usernames. Hence we need to pass toset(["user1", "user2", "user3"]) and then use each.value in the resource block.

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

resource "aws_s3_bucket" "mys3bucket" {
    for_each = {
        dev = "team-dev-bucket"
        uat = "team-uat-bucket"
        sit = "team-sit-bucket"
    }
  bucket = "${each.key}-${each.value}"

  tags = {
    Name        = "${each.key}-${each.value}"
    Environment = each.key
  }
}

#creating three differnt users

resource "aws_iam_user" "my-users" {
    for_each = toset(["user1", "user2", "user3"])
  name = each.value
  path = "/system/"

  tags = {
    tag-key = each.value
  }
}