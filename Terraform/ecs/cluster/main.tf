resource "aws_ecs_cluster" "ecs-cluster" {
  name = "${var.product}-${local.environment}-ecs-cluster"
  tags = local.tags
}

resource "aws_ecs_cluster_capacity_providers" "example" {
  cluster_name = aws_ecs_cluster.ecs-cluster.name

  capacity_providers = ["FARGATE","FARGATE_SPOT"]

   dynamic "default_capacity_provider_strategy" { 
    for_each = try(local.env_conf.capacity_provider_strategy, [])
    content {
      base              = capacity_provider_strategy.value.base
      capacity_provider = capacity_provider_strategy.value.capacity_provider
      weight            = capacity_provider_strategy.value.weight
    }

  }
}