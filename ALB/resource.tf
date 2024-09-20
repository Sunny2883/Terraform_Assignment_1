# ALB Configuration
resource "aws_alb" "this" {
  internal                     = false
  load_balancer_type           = "application"
  subnets                      = var.subnets
  security_groups              = var.security_groups
  enable_deletion_protection    = false
}

# Target Group for EC2
resource "aws_lb_target_group" "ec2_target_group" {
  count    = var.use_fargate ? 0 : 1  # Only create if not using Fargate
  name     = "tg-ec2"
  port     = 8080
  protocol = "HTTP"
  vpc_id   = var.vpc_id

  health_check {
    path                = "/api/books"
    protocol            = "HTTP"
    interval            = 30
    timeout             = 5
    healthy_threshold   = 3
    unhealthy_threshold = 3
  }
}

# Target Group for Fargate
resource "aws_lb_target_group" "fargate_target_group" {
  count    = var.use_fargate ? 1 : 0  # Only create if using Fargate
  name     = "tg-fargate"
  port     = 8080
  protocol = "HTTP"
  vpc_id   = var.vpc_id
  target_type = "ip"  # Use 'ip' for Fargate compatibility

  health_check {
    path                = "/api/books"
    protocol            = "HTTP"
    interval            = 30
    timeout             = 5
    healthy_threshold   = 3
    unhealthy_threshold = 3
  }
}

# HTTP Listener
resource "aws_lb_listener" "listener" {
  load_balancer_arn = aws_alb.this.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type = "redirect"
    redirect {
      port        = "443"
      protocol    = "HTTPS"
      status_code = "HTTP_301"
    }
  }
}

# HTTPS Listener
resource "aws_lb_listener" "https" {
  load_balancer_arn = aws_alb.this.arn
  port              = 443
  protocol          = "HTTPS"
  ssl_policy        = "ELBSecurityPolicy-2016-08"
  certificate_arn   = "arn:aws:acm:ap-south-1:396608771618:certificate/a8506c21-5783-417d-809a-10789c61c78f"

  default_action {
    type = "fixed-response"
    fixed_response {
      content_type = "text/plain"
      message_body = "Default HTTPS page"
      status_code  = "200"
    }
  }
}

# Listener Rule for EC2
resource "aws_lb_listener_rule" "ec2_host_header_rule" {
  count = var.use_fargate ? 0 : 1  # Only create if not using Fargate
  listener_arn = aws_lb_listener.https.arn
  priority     = 100

  action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.ec2_target_group[0].arn
  }

  condition {
    host_header {
      values = ["be.sunnykumar.publicvm.com"]
    }
  }
}

# Listener Rule for Fargate
resource "aws_lb_listener_rule" "fargate_host_header_rule" {
  count = var.use_fargate ? 1 : 0  # Only create if using Fargate
  listener_arn = aws_lb_listener.https.arn
  priority     = 200

  action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.fargate_target_group[0].arn
  }

  condition {
    host_header {
      values = ["be.sunnykumar.publicvm.com"]
    }
  }
}

# Redirect Rule for Frontend
resource "aws_lb_listener_rule" "host_header_rule_frontend" {
  listener_arn = aws_lb_listener.https.arn
  priority     = 300

  action {
    type = "redirect"
    redirect {
      host        = var.cloudfront_domain_name
      port        = "443"
      protocol    = "HTTPS"
      status_code = "HTTP_301"
    }
  }

  condition {
    host_header {
      values = ["fe.sunnykumar.publicvm.com"]
    }
  }
}
