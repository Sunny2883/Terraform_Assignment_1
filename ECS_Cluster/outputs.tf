output "task_definition" {
  value = aws_ecs_task_definition.task_def.arn
}
output "cluster_arn" {
  value = aws_ecs_cluster.cluster_assignment.arn
}