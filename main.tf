module "s3_bucket" {
  source      = "./S3_bucket"
  bucket_name = "asdfghuy"
}

module "VPC" {
  source     = "./VPC"
  cidr_block = "192.168.0.0/16"
}

module "subnet" {
  source                   = "./Subnet"
  vpc_id                   = module.VPC.vpc_id
  cidr_block_public_subnet = ["192.168.1.0/24", "192.168.2.0/24"]
  azs                      = ["ap-south-1a", "ap-south-1b"]
  name_db_subnet_group     = "db_subnet_group"
}

module "security_group_assignment_1" {
  source        = "./Security_Group"
  vpc_id        = module.VPC.vpc_id
  security_name = "security_group_assignment_1"
}

module "ASG" {
  source                    = "./ASG"
  image_id                  = "ami-07c0f8a42b483e4cf"
  subnet                    = module.subnet.subnet_id
  security_group_id         = module.security_group_assignment_1.main_security_group_id
  load_balancer             = module.ALB.alb_arn
  health_check_type         = "EC2"
  desired_capacity          = 2
  asg_name                  = "asg_assignment_1"
  min_size                  = 2
  max_size                  = 3
  name                      = ""
  instance_type             = "t2.micro"
  keyname                   = "Project"
  target_group_arn          = module.ALB.backend_target_group_arn
  user_data                 = filebase64("./userdata.sh")
  alb_arn                   = module.ALB.backend_target_group_arn
  iam_instance_profile_name = module.Policy.ecs_instance_profile_name
  use_fargate = true
}

module "ALB" {
  source          = "./ALB"
  vpc_id          = module.VPC.vpc_id
  use_fargate = true
  security_groups = [module.security_group_assignment_1.main_security_group_id]
  subnets         = module.subnet.subnet_id
  name            = "ALB_assignment_1"
  cloudfront_domain_name = module.cloudfront.cloudfront_arn
}

module "ECS_Services" {
  source           = "./ECS_Services"
  ecs_service_name = "Service_assignment_1"
  desired_count    = 2
  task_definition  = module.ECS_cluster.task_definition
  cluster_arn      = module.ECS_cluster.cluster_arn
  use_fargate = true
  subnets = module.subnet.subnet_id
  security_group_id = module.security_group_assignment_1.ecs_security_group_id
  ec2_target_group_arn = null
  fargate_target_group_arn = module.ALB.backend_target_group_arn
  
}

module "ECS_cluster" {
  source                       = "./ECS_Cluster"
  cluster_name                 = "cluster_assignment"
  family_name                  = "Assignment_family_1"
  task_name                    = "Assignment_task_1"
  memory                       = 256
  cpu                          = 128
  image_url                    = module.ECR.ecr_repository_url
  execution_role_arn           = module.Policy.ecs_task_execution_role_arn
  task_role_arn                = module.Policy.ecs_task_role_arn
  log_stream_prefix            = "assignment"
  aws_region                   = "ap-south-1"
  log_group_name               = module.cloudwatch.log_group_name
  auto_scaling_group_arn       = module.ASG.asg_arn
  connection_address           = module.parameter_store.parameter_name_arn
  allowedhost                  = module.parameter_store.allwedhost_arn
  Logging__LogLevel__Default   = module.parameter_store.Logging__LogLevel__Default_arn
  Logging__LogLevel__Microsoft = module.parameter_store.Logging__LogLevel__Microsoft
  use_fargate = true
}
module "Policy" {
  source = "./Policies"

}

module "cloudwatch" {
  source            = "./Cloudwatch"
  cloudwatch_name   = "projectloggroup"
  retention_in_days = "0"
  log_group_class   = "STANDARD"
}

module "database" {
  source                 = "./Databse"
  engine                 = "postgres"
  engine_version         = "12.16"
  vpc_security_group_ids = [module.security_group_assignment_1.db_security_group_id]
  username               = "assignmentuser"
  allocated_storage      = 20
  db_name                = "assignmentdbs"
  db_subnet_group_name   = module.subnet.db_subnet_group_name
  instance_class         = "db.t3.micro"
  identifier = "assignment-db-instance"
}

module "parameter_store" {
  source                                      = "./Parameter-Store"
  parameter_name                              = "ConnectionStrings__DefaultConnection"
  password                                    = module.database.random_password
  dbname                                      = module.database.dbname
  username                                    = module.database.username
  address                                     = module.database.address
  AllowedHosts_value                          = "*"
  Logging__LogLevel__Default_value            = "Information"
  Logging__LogLevel__Microsoft_value          = "Warning"
  parameter_name_AllowedHosts                 = "AllowedHosts"
  parameter_name_Logging__LogLevel__Default   = "Logging__LogLevel__Default"
  parameter_name_Logging__LogLevel__Microsoft = "Logging__LogLevel__Microsoft.AspNetCore"
}

module "cloudfront" {
  source = "./cloudfront"
}

module "ECR" {
  source = "./ECR"
  
}