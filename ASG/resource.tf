resource "aws_launch_template" "ecs_launch_template" {
  count        = var.use_fargate ? 0 : 1  # Create launch template only if not using Fargate

  name          = "${var.asg_name}-launch-template"
  image_id      = var.image_id
  instance_type = var.instance_type
  user_data     = var.user_data
  key_name      = var.keyname

  iam_instance_profile {
    name = var.iam_instance_profile_name
  }

  network_interfaces {
    associate_public_ip_address = true
    security_groups = [var.security_group_id]
  }
}

resource "aws_autoscaling_group" "ASG_assignment_1" {
  count = var.use_fargate ? 0 : 1  # Create ASG only if not using Fargate

  name                      = var.asg_name
  max_size                  = var.max_size
  min_size                  = var.min_size
  health_check_grace_period = 300
  health_check_type         = var.health_check_type
  desired_capacity          = var.desired_capacity
  force_delete              = true
  vpc_zone_identifier       = var.subnet
  target_group_arns         = [var.target_group_arn]

  launch_template {
    id      = aws_launch_template.ecs_launch_template[0].id
    version = "$Latest"
  }
}

resource "aws_autoscaling_attachment" "this" {
  count = var.use_fargate ? 0 : 1  # Create attachment only if not using Fargate

  autoscaling_group_name = aws_autoscaling_group.ASG_assignment_1[0].id
  lb_target_group_arn    = var.target_group_arn
}
