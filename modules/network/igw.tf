resource "aws_internet_gateway" "igw-default" {
  vpc_id = aws_vpc.vpc-default.id

  tags = {
    Name = "igw-default"
  }
}