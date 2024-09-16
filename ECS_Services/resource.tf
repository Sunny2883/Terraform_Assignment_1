resource "aws_ecs_service" "ecs_service" {
  name            = var.ecs_service_name
  cluster         = var.cluster_arn
  task_definition = var.task_definition
  
  desired_count   = var.desired_count

    deployment_controller {
    type = "ECS"
  }

  deployment_maximum_percent = 200
  deployment_minimum_healthy_percent = 100
  
}
