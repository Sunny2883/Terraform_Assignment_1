resource "aws_subnet" "public_subnet_assignment_1" {
 count      = length(var.cidr_block_public_subnet)
 vpc_id     = var.vpc_id
 cidr_block = element(var.cidr_block_public_subnet, count.index)
 availability_zone = var.azs[count.index]
 tags = {
   Name = "Public Subnet ${count.index + 1}"
 }
}


resource "aws_internet_gateway" "internet_gateway_assignment_1" {
  vpc_id = var.vpc_id
}

resource "aws_route_table" "route_table_assignment_1" {
  vpc_id = var.vpc_id
}

resource "aws_route" "internet_route" {
  route_table_id         = aws_route_table.route_table_assignment_1.id
  destination_cidr_block = "0.0.0.0/0" 
  gateway_id             = aws_internet_gateway.internet_gateway_assignment_1.id
}

resource "aws_route_table_association" "route_table_association" {
  count = length(var.cidr_block_public_subnet)
  subnet_id = element(aws_subnet.public_subnet_assignment_1[*].id, count.index)
  route_table_id = aws_route_table.route_table_assignment_1.id
  
}




# Subnet in Availability Zone ap-south-1a
resource "aws_subnet" "subnet_1" {
  vpc_id                  = var.vpc_id
  cidr_block              = "192.168.4.0/24"
  availability_zone       = "ap-south-1a"
  map_public_ip_on_launch = false

  tags = {
    Name = "Subnet-1"
  }
}

# Subnet in Availability Zone ap-south-1b
resource "aws_subnet" "subnet_2" {
  vpc_id                  = var.vpc_id
  cidr_block              = "192.168.3.0/24"
  availability_zone       = "ap-south-1b"
  map_public_ip_on_launch = false

  tags = {
    Name = "Subnet-2"
  }
}





resource "aws_db_subnet_group" "db_subnet_group_name" {
  name = var.name_db_subnet_group
  subnet_ids = [ aws_subnet.subnet_1.id, aws_subnet.subnet_2.id ]
}