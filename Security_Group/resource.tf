# Main Security Group
resource "aws_security_group" "main" {
  name        = "main_security_group"
  description = "Main security group for all resources"
  vpc_id      = var.vpc_id

  # Allow HTTP traffic from anywhere
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Allow HTTPS traffic from anywhere
  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  
    ingress {
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = ["192.168.0.0/16"] # Access from the VPC
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]


  }

}

# ECS Security Group
resource "aws_security_group" "ecs" {
  name        = "ecs_security_group"
  description = "Security group for ECS tasks"
  vpc_id      = var.vpc_id

  # Allow traffic to ECS tasks from within the VPC
  ingress {
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = ["192.168.0.0/16"] # Access from the VPC
  }
  
    ingress {
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    security_groups = [aws_security_group.main.id]  # Allow access from main security group (ALB)
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# Database Security Group
resource "aws_security_group" "db" {
  name        = "db_security_group"
  description = "Security group for PostgreSQL database"
  vpc_id      = var.vpc_id

  # Allow traffic to PostgreSQL database
  ingress {
    from_port   = 5432
    to_port     = 5432
    protocol    = "tcp"
    cidr_blocks = ["192.168.0.0/16"]  # Access from the VPC
  }
    ingress {
    from_port   = 5432
    to_port     = 5432
    protocol    = "tcp"
    security_groups = [aws_security_group.main.id]  # Optional: Access from main security group
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
