variable "image_id" {
  type = string
}
variable "instance_type" {
  type = string
}
variable "name" {
  type = string
}
variable "max_size" {
  type = string
  description = "max-size "
}

variable "min_size" {
    type = string
  
}
variable "asg_name" {
  type = string
}

variable "desired_capacity" {
  type = string
}

variable "health_check_type" {
  type = string
}
variable "load_balancer" {
  type = string
}

variable "security_group_id" {
  type = string
}
variable "subnet" {
  type = list(string)
}


variable "alb_arn" {
  type = string
}

variable "user_data" {
  type = string
}
variable "target_group_arn" {
  type = string
}
variable "keyname" {
  type = string
}

variable "iam_instance_profile_name" {
  type = string
}
variable "use_fargate" {
  type = bool
  default = false
}