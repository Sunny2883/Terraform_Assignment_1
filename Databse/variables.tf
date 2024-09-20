variable "allocated_storage" {
  description = "The allocated storage size for the RDS instance in GB."
  type        = number
  default     = 20  # You can change the default value
}

variable "engine" {
  description = "The database engine to use."
  type        = string
  default     = "postgres"
}

variable "engine_version" {
  description = "The version of the database engine."
  type        = string
  default     = "13.3"
}

variable "username" {
  description = "Master username for the database."
  type        = string
}



variable "db_name" {
  description = "Name of the database to create."
  type        = string
  default     = "mydatabase"
}

variable "db_subnet_group_name" {
  description = "The name of the DB subnet group."
  type        = string
}

variable "vpc_security_group_ids" {
  description = "A list of VPC security group IDs to assign to the RDS instance."
  type        = list(string)
}

variable "instance_class" {
  type = string
}
variable "identifier" {
  type = string
}