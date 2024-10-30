data "terraform_remote_state" "vpc" {
  backend = "s3"
  config = {
    bucket  = "terraform-phoenix-state"
    key     = "vpc.tfstate"
    region  = "ap-south-1"
    profile = "personal"
  }
  workspace = local.environment
}

data "terraform_remote_state" "alb" {
  backend = "s3"
  config = {
    bucket  = "terraform-phoenix-state"
    key     = "alb.tfstate"
    region  = "ap-south-1"
    profile = "personal"
  }
  workspace = local.environment
}

data "terraform_remote_state" "ecr" {
  backend = "s3"
  config = {
    bucket  = "terraform-phoenix-state"
    key     = "ecr.tfstate"
    region  = "ap-south-1"
    profile = "personal"
  }
  workspace = local.environment
}
data "terraform_remote_state" "cluster" {
  backend = "s3"
  config = {
    bucket  = "terraform-phoenix-state"
    key     = "cluster.tfstate"
    region  = "ap-south-1"
    profile = "personal"
  }
  workspace = local.environment
}

