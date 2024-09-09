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
}

resource "aws_lb_listener" "listener" {
  load_balancer_arn = aws_alb.this.arn
  port              = 8080
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.this.arn
  }
}