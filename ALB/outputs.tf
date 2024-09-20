output "alb_arn" {
  value = aws_alb.this.arn
}

output "backend_target_group_arn" {
  value = var.use_fargate ? aws_lb_target_group.fargate_target_group[0].arn : aws_lb_target_group.ec2_target_group[0].arn
}
