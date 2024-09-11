output "random_password" {
    value = random_password.database_password.result
}
output "dbname" {
  value = aws_db_instance.postgresrds.db_name
}

output "address" {
  value = aws_db_instance.postgresrds.address
}
output "username" {
  value = aws_db_instance.postgresrds.username
}