output "subnet_id" {
  value = aws_subnet.public_subnet_assignment_1[*].id
}

output "db_subnet_group_name" {
  value = aws_db_subnet_group.db_subnet_group_name.name
}