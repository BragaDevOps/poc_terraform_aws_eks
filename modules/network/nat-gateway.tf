resource "aws_eip" "eip-private-subnet" {
  vpc = true

  tags = {
    Name = "eip-private-subnet"
  }
}

resource "aws_nat_gateway" "nat-private-subnet" {

  allocation_id = aws_eip.eip-private-subnet.id
  subnet_id     = aws_subnet.public-subnet-1a.id
  depends_on    = [aws_internet_gateway.igw-default]

  tags = {
    Name = "nat-gw-default"
  }
}