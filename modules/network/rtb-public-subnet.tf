resource "aws_route_table" "rtb-public-subnet" {
  vpc_id = aws_vpc.vpc-default.id

  tags = {
    Name = "rtb-public-subnet"
  }
}

resource "aws_route" "rtb-public-subnet-internet-access" {
  route_table_id         = aws_route_table.rtb-public-subnet.id
  gateway_id             = aws_internet_gateway.igw-default.id
  destination_cidr_block = "0.0.0.0/0"
}