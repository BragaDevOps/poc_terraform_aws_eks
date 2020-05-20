####################################
# Public Subnet 1a
####################################
resource "aws_subnet" "public-subnet-1a" {
  vpc_id                  = aws_vpc.vpc-default.id
  cidr_block              = var.PUBLIC_SUBNET_CIDER_BLOCK_1A
  map_public_ip_on_launch = true
  availability_zone       = var.PUBLIC_SUBNET_AVAILABILITY_ZONE_1A

  depends_on = [aws_internet_gateway.igw-default]

  tags = {
    Name = "public-subnet-1a",
    "kubernetes.io/cluster/${var.CLUSTER_NAME}" = "shared"
  }
}

resource "aws_route_table_association" "public-subnet-1a-association" {
  subnet_id      = aws_subnet.public-subnet-1a.id
  route_table_id = aws_route_table.rtb-public-subnet.id
}

####################################
# Public Subnet 1b
####################################
resource "aws_subnet" "public-subnet-1b" {
  vpc_id                  = aws_vpc.vpc-default.id
  cidr_block              = var.PUBLIC_SUBNET_CIDER_BLOCK_1B
  map_public_ip_on_launch = true
  availability_zone       = var.PUBLIC_SUBNET_AVAILABILITY_ZONE_1B

  depends_on = [aws_internet_gateway.igw-default]

  tags = {
    Name = "public-subnet-1b",
    "kubernetes.io/cluster/${var.CLUSTER_NAME}" = "shared"
  }
}

resource "aws_route_table_association" "public-subnet-1b-association" {
  subnet_id      = aws_subnet.public-subnet-1b.id
  route_table_id = aws_route_table.rtb-public-subnet.id
}

####################################
# Public Subnet 2b
####################################
resource "aws_subnet" "public-subnet-2b" {
  vpc_id                  = aws_vpc.vpc-default.id
  cidr_block              = var.PUBLIC_SUBNET_CIDER_BLOCK_2B
  map_public_ip_on_launch = true
  availability_zone       = var.PUBLIC_SUBNET_AVAILABILITY_ZONE_2B

  depends_on = [aws_internet_gateway.igw-default]

  tags = {
    Name = "public-subnet-2b",
    "kubernetes.io/cluster/${var.CLUSTER_NAME}" = "shared"
  }
}

resource "aws_route_table_association" "public-subnet-2b-association" {
  subnet_id      = aws_subnet.public-subnet-2b.id
  route_table_id = aws_route_table.rtb-public-subnet.id
}
