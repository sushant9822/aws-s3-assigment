locals {
  region      = var.regions[terraform.workspace]
  environment = terraform.workspace
  env_conf    = lookup(var.environment, local.environment)
  tags = {
    Environment        = local.environment
    Use_case           = "ecr-repository"
    ProjectName        = "phoenix"
    Can_be_deleted     = true
    CreatedByTerraform = true
  }
}