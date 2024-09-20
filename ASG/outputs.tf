output "asg_id" {
  value = var.use_fargate ? null : aws_autoscaling_group.ASG_assignment_1[0].id
}

output "asg_arn" {
  value = var.use_fargate ? null : aws_autoscaling_group.ASG_assignment_1[0].arn
}
