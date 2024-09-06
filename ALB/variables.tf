variable "name" {
  type = string
}

variable "subnets" {
  type = list(string)
}

variable "security_groups" {
  type = list(string)
}

variable "target_type" {
  type = string
}
variable "vpc_id" {
  type = string
}

