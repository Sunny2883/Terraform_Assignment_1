variable "desired_count" {
  type = string
}
variable "ecs_service_name" {
  type = string
}
variable "task_definition" {
  type = string
}

variable "cluster_arn" {
  type = string
}



variable "use_fargate" {
  description = "Set to true to use Fargate launch type"
  type        = bool
  default     = false
}
variable "security_group_id" {
  type = string
}
variable "subnets" {
  type = list(string)
}
variable "ec2_target_group_arn" {
  type = string
}
variable "fargate_target_group_arn" {
  type = string
}