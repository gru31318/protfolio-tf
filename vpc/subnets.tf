resource "aws_subnet" "subnet_1" {
  vpc_id            = aws_vpc.vpc.id
  cidr_block        = var.cidr_subnets[0]
  availability_zone = var.availability_zones[0]

  tags = {
    Name = "${var.prefix}-sub-1"
  }
}

resource "aws_subnet" "subnet_2" {
  vpc_id            = aws_vpc.vpc.id
  cidr_block        = var.cidr_subnets[1]
  availability_zone = var.availability_zones[1]

  tags = {
    Name = "${var.prefix}-sub-2"
  }
}