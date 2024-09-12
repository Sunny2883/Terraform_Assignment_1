resource "aws_alb" "this" {

  internal           = false
  load_balancer_type = "application"
  subnets            = var.subnets
  security_groups    = var.security_groups
  
  enable_deletion_protection = false
}



resource "aws_lb_target_group" "this" {
  name     = "tg"
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

resource "aws_lb_listener" "listener" {
  load_balancer_arn = aws_alb.this.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type             = "redirect"
    redirect {
      port = 443
      protocol = "HTTPS"
      status_code = "HTTP_301"
    }
  }
}

resource "aws_lb_listener" "https" {
  load_balancer_arn = aws_alb.this.arn
  port              = 443
  protocol          = "HTTPS"
  ssl_policy        = "ELBSecurityPolicy-2016-08"
  certificate_arn   = "arn:aws:acm:ap-south-1:396608771618:certificate/a8506c21-5783-417d-809a-10789c61c78f"
  depends_on        = [aws_lb_target_group.this]

  default_action {
    target_group_arn = aws_lb_target_group.this.arn
    type             = "forward"
  }
}
