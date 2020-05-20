####################################
# Private Subnet 1a
####################################
resource "aws_subnet" "private-subnet-1a" {
  vpc_id                  = aws_vpc.vpc-default.id
  cidr_block              = var.PRIVATE_SUBNET_CIDER_BLOCK_1A
  map_public_ip_on_launch = false
  availability_zone       = var.PRIVATE_SUBNET_AVAILABILITY_ZONE_1A

  tags = {
    Name = "private-subnet-1a",
    "kubernetes.io/cluster/${var.CLUSTER_NAME}" = "shared"
  }
}

resource "aws_route_table_association" "private-subnet-1a-association" {
  subnet_id      = aws_subnet.private-subnet-1a.id
  route_table_id = aws_route_table.rtb-private-subnet.id
}

####################################
# Private Subnet 1b
####################################
resource "aws_subnet" "private-subnet-1b" {
  vpc_id                  = aws_vpc.vpc-default.id
  cidr_block              = var.PRIVATE_SUBNET_CIDER_BLOCK_1B
  map_public_ip_on_launch = false
  availability_zone       = var.PRIVATE_SUBNET_AVAILABILITY_ZONE_1B

  tags = {
    Name = "private-subnet-1b",
    "kubernetes.io/cluster/${var.CLUSTER_NAME}" = "shared"
  }
}

resource "aws_route_table_association" "private-subnet-1b-association" {
  subnet_id      = aws_subnet.private-subnet-1b.id
  route_table_id = aws_route_table.rtb-private-subnet.id
}

####################################
# Private Subnet 2b
####################################
resource "aws_subnet" "private-subnet-2b" {
  vpc_id                  = aws_vpc.vpc-default.id
  cidr_block              = var.PRIVATE_SUBNET_CIDER_BLOCK_2B
  map_public_ip_on_launch = false
  availability_zone       = var.PRIVATE_SUBNET_AVAILABILITY_ZONE_2B

  tags = {
    Name = "private-subnet-2b",
    "kubernetes.io/cluster/${var.CLUSTER_NAME}" = "shared"
  }
}

resource "aws_route_table_association" "private-subnet-2b-association" {
  subnet_id      = aws_subnet.private-subnet-2b.id
  route_table_id = aws_route_table.rtb-private-subnet.id
}