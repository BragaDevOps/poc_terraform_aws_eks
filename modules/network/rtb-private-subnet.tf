resource "aws_route_table" "rtb-private-subnet" {
  vpc_id = aws_vpc.vpc-default.id

  tags = {
    Name = "rtb-private-subnet"
  }
}

resource "aws_route" "rtb-private-subnet-nat-access" {
  route_table_id = aws_route_table.rtb-private-subnet.id
  nat_gateway_id = aws_nat_gateway.nat-private-subnet.id
  destination_cidr_block = "0.0.0.0/0"

  depends_on    = [aws_nat_gateway.nat-private-subnet]
}