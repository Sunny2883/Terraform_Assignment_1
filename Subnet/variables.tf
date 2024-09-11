variable "vpc_id" {
  type = string
}

variable "cidr_block_public_subnet" {
  type = list(string)
  default     = ["10.0.1.0/24", "10.0.2.0/24"]
}

variable "azs" {
   type        = list(string)
 description = "Availability Zones"
 default     =  ["ap-south-1a", "ap-south-1b"]
}
variable "name_db_subnet_group" {
  
}