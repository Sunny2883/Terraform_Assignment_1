variable "name" {
  type = string
  description = "The name to assign to the resource, such as a load balancer or application."
}

variable "subnets" {
  type = list(string)
  description = "A list of subnet IDs where the resource will be deployed. These should belong to the specified VPC."
}

variable "security_groups" {
  type = list(string)
  description = "A list of security group IDs to associate with the resource, which control inbound and outbound traffic."
}



variable "vpc_id" {
  type = string
  description = "The ID of the Virtual Private Cloud (VPC) in which the resource will be created. This defines the networking boundaries for the resource."
}

variable "cloudfront_domain_name" {
  type = string
  description = "The domain name of the CloudFront distribution associated with the resource. This is used for routing and access control."
}

variable "use_fargate" {
  type = bool
  default = false
}