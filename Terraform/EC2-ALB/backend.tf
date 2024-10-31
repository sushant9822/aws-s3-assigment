terraform {
  backend "s3" {
    bucket  = "terraform-phoenix-state"
    key     = "ec2-alb.tfstate"
    region  = "ap-south-1"
    profile = "personal"
  }

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "4.22.0"
    }
  }
}

provider "aws" {
  region  = local.region
  profile = local.env_conf.profile
} 