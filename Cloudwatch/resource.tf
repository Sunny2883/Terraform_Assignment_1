resource "aws_cloudwatch_log_group" "projectloggroup" {
  name = var.cloudwatch_name
  log_group_class = var.log_group_class
  retention_in_days = var.retention_in_days
  tags = {
    Environment = "production"
  }
}