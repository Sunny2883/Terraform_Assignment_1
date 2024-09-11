output "ecs_task_execution_role_arn" {
  description = "The ARN of the ECS Task Execution Role"
  value       = aws_iam_role.ecs_task_execution_role.arn
}

output "ecs_instance_role_arn" {
  description = "The ARN of the ECS Instance Role"
  value       = aws_iam_role.ecs_instance_role.arn
}

output "ecs_instance_profile_arn" {
  description = "The ARN of the ECS Instance Profile"
  value       = aws_iam_instance_profile.ecs_instance_profile_project.arn
}

output "ecs_instance_profile_name" {
  description = "The name of the ECS Instance Profile"
  value       = aws_iam_instance_profile.ecs_instance_profile_project.name
}
output "ecs_task_role_arn" {
  value = aws_iam_role.ecs_task_role.arn
}