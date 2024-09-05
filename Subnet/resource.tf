resource "aws_subnet" "private_subnet_assignment_1" {
  vpc_id = var.vpc_id
  cidr_block = var.cidr_block
}

resource "aws_internet_gateway" "internet_gateway_assignment_1" {
  vpc_id = var.vpc_id
}

resource "aws_route_table" "route_table_assignment_1" {
  vpc_id = var.vpc_id
}

resource "aws_route_table_association" "public_association_assignment_1" {
  subnet_id      = aws_subnet.private_subnet_assignment_1.id
  route_table_id = aws_route_table.route_table_assignment_1.id
}