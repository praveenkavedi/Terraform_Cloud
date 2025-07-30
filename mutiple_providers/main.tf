#mutiple provider is acchieved by using alias in the provider block and use provider argument in the resource block.
#if mutiple account, then eother pass the creds in the respective provider block or update the credentials file like 
    #[account_1]
        # aws_access_key_id = "AKIA..."
        # aws_secret_access_key = "secret"
    #[account_2]
        # aws_access_key_id = "AKIA..."
        # aws_secret_access_key = "secret"


terraform {
  required_version = "~> 1.11.0"
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
#singapore provider

provider "aws" {
  region = "ap-southeast-1"
  alias  = "sing"  
}

resource "aws_vpc" "mum-vpc" {
  cidr_block       = "10.0.0.0/16"
  instance_tenancy = "default"

  tags = {
    Name = "mum-vpc"
  }
}

resource "aws_vpc" "sing-vpc" {
  cidr_block       = "10.0.0.0/16"
  instance_tenancy = "default"
  provider = aws.sing
    # Use the Singapore provider
  tags = {
    Name = "sing-vpc"
  }
}