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
