resource "aws_subnet" "subnet_1" {
  vpc_id            = aws_vpc.vpc.id
  cidr_block        = var.cidr_subnets[0]
  availability_zone = var.availability_zones[0]
  map_public_ip_on_launch = true

  tags = {
    Name = "${var.prefix}-sub-1"
    "kubernetes.io/cluster/eks" = "shared"
    "kubernetes.io/role/elb" = 1
  }
}

resource "aws_subnet" "subnet_2" {
  vpc_id            = aws_vpc.vpc.id
  cidr_block        = var.cidr_subnets[1]
  availability_zone = var.availability_zones[1]
  map_public_ip_on_launch = true

  tags = {
    Name = "${var.prefix}-sub-2"
    "kubernetes.io/cluster/eks" = "shared"
    "kubernetes.io/role/elb" = 1
  }
}