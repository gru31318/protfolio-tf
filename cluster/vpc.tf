resource "aws_vpc" "vpc" {
  cidr_block = var.cidr_vpc
  tags = {
    Name = "${var.prefix}-vpc"
  }
}

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.vpc.id

  tags = {
    Name = "${var.prefix}-igw"
  }
}

resource "aws_route_table" "rtb" {
  vpc_id = aws_vpc.vpc.id

  route {
    cidr_block = var.anyone_cidr
    gateway_id = aws_internet_gateway.igw.id
  }

  tags = {
    Name = "${var.prefix}-rtb"
  }
}

resource "aws_main_route_table_association" "rtb" {
  vpc_id         = aws_vpc.vpc.id
  route_table_id = aws_route_table.rtb.id
}