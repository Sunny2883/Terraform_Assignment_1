resource "aws_ecs_service" "ecs_service" {
  name            = var.ecs_service_name
  cluster         = var.cluster_arn
  task_definition = var.task_definition
  desired_count   = var.desired_count

  # Load balancer configuration
  dynamic "load_balancer" {
    for_each = var.use_fargate ? [1] : [1]  # Include for both Fargate and EC2
    content {
      target_group_arn = var.use_fargate ? var.fargate_target_group_arn : var.ec2_target_group_arn
      container_name   = "Assignment_task_1"
      container_port   = 8080
    }
  }

  deployment_controller {
    type = "ECS"
  }

  deployment_maximum_percent            = 200
  deployment_minimum_healthy_percent     = 50

  # Launch type
  launch_type = var.use_fargate ? "FARGATE" : "EC2"

  # Fargate-specific network configuration
  dynamic "network_configuration" {
    for_each = var.use_fargate ? [1] : []  # Only include for Fargate
    content {
      subnets          = var.subnets
      security_groups  = [var.security_group_id]
      assign_public_ip = true
    }
  }
}
