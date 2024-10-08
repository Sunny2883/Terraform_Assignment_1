variable "cluster_name" {
  type = string
}

variable "family_name" {
  type = string
}

variable "task_name" {
  type = string
}

variable "memory" {
  type = string
}

variable "cpu" {
  type = string
}

variable "image_url" {
  type = string
}
variable "execution_role_arn" {
  type = string
}
variable "task_role_arn" {
  type = string
}
variable "log_group_name" {
  description = "Name of the CloudWatch Logs group"
}

variable "aws_region" {
  description = "AWS region"
}

variable "log_stream_prefix" {
  description = "Prefix for the CloudWatch Logs stream"
}

variable "auto_scaling_group_arn" {
  type = string
}