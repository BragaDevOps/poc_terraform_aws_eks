resource "aws_vpc" "vpc-default" {
  cidr_block           = var.VPC_CIDR_BLOCK
  instance_tenancy     = var.VPC_INSTANCE_TENACY
  enable_dns_support   = var.DNS_SUPPORT
  enable_dns_hostnames = var.DNS_HOST_NAMES
  tags = {
    Name = "VPC"
  }
}