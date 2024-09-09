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