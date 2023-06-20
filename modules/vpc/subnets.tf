resource "aws_subnet" "subnets" {
  count                   = var.sub_count
  vpc_id                  = aws_vpc.vpc.id
  cidr_block              = cidrsubnet(aws_vpc.vpc.cidr_block, 4, count.index)
  availability_zone       = data.aws_availability_zones.available.names[count.index % length(data.aws_availability_zones.available.names)]
  map_public_ip_on_launch = true

  tags = {
    Name                                 = "${var.prefix}-sub"
    "kubernetes.io/cluster/dressify-eks" = "shared"
    "kubernetes.io/role/elb"             = 1
  }
}

