resource "aws_security_group" "cluster_master_sg" {

    name = format("%s-master-sg", var.CLUSTER_NAME)
    vpc_id = var.CLUSTER_VPC.id

    egress {
        from_port   = 0
        to_port     = 0

        protocol = "-1"
        cidr_blocks = [ "0.0.0.0/0" ]
    }

    tags = {
        Name = format("%s-master-sg", var.CLUSTER_NAME)
    }
}

resource "aws_security_group_rule" "cluster_ingress_https" {
    cidr_blocks = ["0.0.0.0/0"]
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"

    security_group_id = aws_security_group.cluster_master_sg.id
    type = "ingress"
}