resource "aws_network_acl" "nacl-private-subnet" {
  vpc_id = aws_vpc.vpc-default.id

  subnet_ids = [
    aws_subnet.private-subnet-1a.id,
    aws_subnet.private-subnet-1b.id,
    aws_subnet.private-subnet-2b.id
  ]

  tags = {
    Name = "nacl-private-subnet"
  }
}

resource "aws_network_acl_rule" "nacl-private-subnet-allow-ingress" {
    network_acl_id = aws_network_acl.nacl-private-subnet.id
    rule_number = 100
    egress = false
    protocol = "-1"
    rule_action = "allow"
    cidr_block = "0.0.0.0/0"
    from_port = "0"
    to_port = "0"
}

resource "aws_network_acl_rule" "nacl-private-subnet-allow-egress" {
    network_acl_id = aws_network_acl.nacl-private-subnet.id
    rule_number = 100
    egress = true
    protocol = "-1"
    rule_action = "allow"
    cidr_block = "0.0.0.0/0"
    from_port = "0"
    to_port = "0"
    icmp_type = "0"
    icmp_code = "0"
}
