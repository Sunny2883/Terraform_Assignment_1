output "subnet_id" {
  value = aws_subnet.public_subnet_assignment_1[*].id
}