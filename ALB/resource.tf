resource "aws_alb" "this" {
  name               = var.name
  internal           = false
  load_balancer_type = "application"
  subnets            = var.subnets
  security_groups    = var.security_groups
  
  enable_deletion_protection = false
}






resource "aws_alb_target_group" "this" {
  target_type = var.target_type
  name        = "ecs-tg"
  protocol    = "HTTP"
  vpc_id      = var.vpc_id
  port        = 4200
  
}

resource "aws_lb_target_group" "backend_target_group" {
  name     = "backend-target-group"
  port     = 8080
  protocol = "HTTP"
  vpc_id   = var.vpc_id
}

resource "aws_lb_listener" "listener" {
  load_balancer_arn = aws_alb.name.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_alb_target_group.this.arn
  }
}