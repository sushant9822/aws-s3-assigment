regions = {
  prod = "ap-south-1"
}
environment = {
  prod = {
    region           = "ap-south-1"
    profile          = "personal"
    cloud_service_cd = "phoenix-s3-service.json"
    assign_public_ip = false
    capacity_provider_strategy = [
      {
        base              = 0
        capacity_provider = "FARGATE_SPOT"
        weight            = 1
      }
    ]

  }
}
