resource "aws_ecs_service" "cloud-service" {
  name    = "${var.product}-${local.environment}-s3-service"
  cluster = data.terraform_remote_state.cluster.outputs.cluster_id
  task_definition                   = aws_ecs_task_definition.cloud-service.arn
  platform_version                  = "1.4.0"
  health_check_grace_period_seconds = 300
  dynamic "capacity_provider_strategy" {
    for_each = try(local.env_conf.capacity_provider_strategy, [])
    content {
      base              = capacity_provider_strategy.value.base
      capacity_provider = capacity_provider_strategy.value.capacity_provider
      weight            = capacity_provider_strategy.value.weight
    }

  }

  deployment_controller {
    type = "ECS"
  }
  lifecycle {
    # create_before_destroy = true
    ignore_changes = [task_definition, desired_count]
  }

  deployment_circuit_breaker {
    enable   = true
    rollback = true
  }

  desired_count = 0

  load_balancer {
    elb_name         = ""
    target_group_arn = data.terraform_remote_state.alb.outputs.alb_details.target_group_arns[0]
    container_name   = "s3-service"
    container_port   = 8000
  }
  network_configuration {
  subnets         = ["${data.terraform_remote_state.vpc.outputs.vpc_details.private_subnets[0]}", "${data.terraform_remote_state.vpc.outputs.vpc_details.private_subnets[1]}", "${data.terraform_remote_state.vpc.outputs.vpc_details.private_subnets[1]}", "${data.terraform_remote_state.vpc.outputs.vpc_details.private_subnets[2]}"]
  security_groups  = ["${module.security_group.security_group_id}"]
  assign_public_ip = false
  }
}

resource "aws_ecs_task_definition" "cloud-service" {
  family                   = "${var.product}-${local.environment}-s3-service"
  requires_compatibilities = ["FARGATE"]
  container_definitions    = file(local.env_conf.cloud_service_cd)
  cpu                      = 256
  execution_role_arn       = aws_iam_role.ecsTaskExecutionRole.arn
  network_mode             = "awsvpc"
  memory                   = 512
}

module "security_group" {
  source  = "terraform-aws-modules/security-group/aws"
  version = "4.9.0"

  name        = "${var.product}-${local.environment}-service-sg"
  description = "Security group for Service"
  vpc_id      = data.terraform_remote_state.vpc.outputs.vpc_details.vpc_id
  tags        = local.tags

  ingress_with_cidr_blocks = [
    {
      from_port   = 8000
      to_port     = 8000
      protocol    = "tcp"
      cidr_blocks = "10.40.0.0/20"
    }
  ]

  egress_with_cidr_blocks = [
    {
      from_port   = 0
      to_port     = 0
      protocol    = -1
      cidr_blocks = "0.0.0.0/0"
    },
  ]
}
