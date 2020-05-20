
output "cluster_vpc" {
  value = aws_vpc.vpc-default
}

output "private_subnet_1a" {
  value = aws_subnet.private-subnet-1a
}

output "private_subnet_1b" {
  value = aws_subnet.private-subnet-1b
}

output "private_subnet_2b" {
  value = aws_subnet.private-subnet-2b
}

output "public_subnet_1a" {
  value = aws_subnet.public-subnet-1a
}

output "public_subnet_1b" {
  value = aws_subnet.public-subnet-1b
}

output "public_subnet_2b" {
  value = aws_subnet.public-subnet-2b
}