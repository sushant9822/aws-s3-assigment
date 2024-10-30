regions = {
  prod = "ap-south-1"
}
environment = {
  prod = {
    region = "ap-south-1"
    profile = "personal"
    default_capacity_provider_strategy = [
      {
        base              = 0
        capacity_provider = "FARGATE_SPOT"
        weight            = 1
      }
    ]
  }
}