resource "aws_ecs_service" "ecs_service" {
  name            = var.ecs_service_name
  cluster         = var.cluster_arn
  task_definition = var.task_definition
  
  desired_count   = var.desired_count
    load_balancer {
    target_group_arn = var.target_group_arn
    container_name   = "Assignment_task_1"
    container_port   = 8080
  }
    deployment_controller {
    type = "ECS"
  }

  deployment_maximum_percent = 200
  deployment_minimum_healthy_percent = 50

  
  
}
