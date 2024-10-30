terraform {
  backend "s3" {
    bucket  = "terraform-phoenix-state"
    key     = "alb.tfstate"
    region  = "ap-south-1"
    profile = "personal"
  }

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "4.54.0"
    }
  }
}

provider "aws" {
  region  = local.region
  profile = local.env_conf.profile
}
