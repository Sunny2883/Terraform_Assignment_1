output "parameter_name_arn" {
  value = aws_ssm_parameter.ConnectionStrings__DefaultConnection.arn
}

output "allwedhost_arn" {
  value = aws_ssm_parameter.AllowedHosts.arn
}
output "Logging__LogLevel__Default_arn" {
  value = aws_ssm_parameter.Logging__LogLevel__Default.arn
}
output "Logging__LogLevel__Microsoft" {
  value = aws_ssm_parameter.Logging__LogLevel__Microsoft.arn
}