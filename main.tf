module "s3_bucket" {
  source      = "./S3_bucket"
  bucket_name = "asdfghuy"
}

module "VPC" {
  source     = "./VPC"
  cidr_block = "192.168.0.0/16"
}

module "subnet" {
  source     = "./Subnet"
  vpc_id     = module.VPC.vpc_id
  cidr_block_public_subnet =   ["192.168.1.0/24", "192.168.2.0/24"]
  azs = ["ap-south-1a", "ap-south-1b"]
  
}

module "security_group_assignment_1" {
  source        = "./Security_Group"
  vpc_id        = module.VPC.vpc_id
  security_name = "security_group_assignment_1"
}

module "ASG" {
  source            = "./ASG"
  image_id          = "ami-0522ab6e1ddcc7055"
  subnet            = module.subnet.subnet_id
  security_group_id = module.security_group_assignment_1.security_group_id
  load_balancer     = module.ALB.alb_arn
  health_check_type = "EC2"
  desired_capacity  = 1
  asg_name          = "asg_assignment_1"
  min_size          = 1
  max_size          = 2
  name              = ""
  instance_type     = "t2.micro"
  keyname           = "Project"
  target_group_arn  = module.ALB.backend_target_group_arn
  user_data         = ""
  alb_arn           = module.ALB.backend_target_group_arn
}

module "ALB" {
  source          = "./ALB"
  vpc_id          = module.VPC.vpc_id
  target_type     = "instance"
  security_groups = [module.security_group_assignment_1.security_group_id]
  subnets         = module.subnet.subnet_id
  name            = "ALB_assignment_1"
}