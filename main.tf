module "s3_bucket" {
  source = "./S3_bucket"
  bucket_name = "react-app-bucket-assignment-1"
}

module "VPC" {
 source = "./VPC"
 cidr_block = "192.168.0.0/16"
}

module "subnet" {
    source = "./Subnet"
    vpc_id = module.VPC.vpc_id
    cidr_block = 
  
}