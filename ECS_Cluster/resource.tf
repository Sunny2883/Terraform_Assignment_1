resource "aws_ecs_cluster" "cluster_assignment" {
  name = var.cluster_name
}

resource "aws_ecs_task_definition" "task_def" {
  family                = var.family_name
  network_mode          = "bridge"
  execution_role_arn    = var.execution_role_arn
  task_role_arn         = var.task_role_arn

  container_definitions = jsonencode([
    {
      name          = var.task_name
      image         = var.image_url
      cpu           = tonumber(var.cpu)
      memory        = tonumber(var.memory)
      essential     = true
      portMappings  = [
        {
          containerPort = 8080
          hostPort      = 8080
        }
      ],

          "logConfiguration": {
      "logDriver": "awslogs",
      "options": {
        "awslogs-group": "projectloggroup", 
        "awslogs-region": "ap-south-1",
        "awslogs-stream-prefix": "streaming"
      }
    }

            "healthCheck": {
        "command": [
          "CMD-SHELL",
          "curl -f http://localhost:8080/swagger || exit 1"
        ],
        "interval": 30,
        "timeout": 5,
        "retries": 3,
        "startPeriod": 60
      }
      logConfiguration = {
        logDriver = "awslogs",
        options = {
          "awslogs-group"         = var.log_group_name
          "awslogs-region"        = var.aws_region
          "awslogs-stream-prefix" = var.log_stream_prefix
        }
      },
            secrets = [
        {
          name      = "AllowedHosts"
          valueFrom = "arn:aws:ssm:us-east-1:396608771618:parameter/AllowedHosts"
        },
        {
          name      = "ConnectionStrings__DefaultConnection"
          valueFrom = "arn:aws:ssm:us-east-1:396608771618:parameter/ConnectionStrings__DefaultConnection"
        },
        {
          name      = "Logging__LogLevel__Default"
          valueFrom = "arn:aws:ssm:us-east-1:396608771618:parameter/Logging__LogLevel__Default"
        },
        {
          name      = "Logging__LogLevel__Microsoft.AspNetCore"
          valueFrom = "arn:aws:ssm:us-east-1:396608771618:parameter/Logging__LogLevel__Microsoft.AspNetCore"
        }
      ]
    }
  ])


}

resource "aws_ecs_capacity_provider" "ecs_capacity_provider" {
  name = "my-capacity-provider"

  auto_scaling_group_provider {
    auto_scaling_group_arn         = var.auto_scaling_group_arn
    managed_termination_protection = "DISABLED"

    managed_scaling {
      status                    = "ENABLED"
      target_capacity           = 100
      minimum_scaling_step_size = 1
      maximum_scaling_step_size = 100
    }
  }
}

resource "aws_ecs_cluster_capacity_providers" "ecs_capacity_providers" {
  cluster_name       = aws_ecs_cluster.cluster_assignment.name
  capacity_providers = [aws_ecs_capacity_provider.ecs_capacity_provider.name]
}
