output "main_security_group_id" {
  description = "The ID of the main security group"
  value       = aws_security_group.main.id
}

output "ecs_security_group_id" {
  description = "The ID of the ECS security group"
  value       = aws_security_group.ecs.id
}

output "db_security_group_id" {
  description = "The ID of the database security group"
  value       = aws_security_group.db.id
}
