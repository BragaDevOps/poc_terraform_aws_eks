resource "aws_eks_cluster" "eks_cluster" {

    name    = var.CLUSTER_NAME
    version = var.K8S_VERSION
    role_arn = aws_iam_role.eks_cluster_role.arn

    vpc_config {
        security_group_ids = [
            aws_security_group.cluster_master_sg.id
        ]

        subnet_ids = [
            var.PRIVATE_SUBNET_1A.id,
            var.PRIVATE_SUBNET_1B.id,
            var.PRIVATE_SUBNET_2B.id
        ]

        endpoint_public_access  = true
        endpoint_private_access = true
        
        public_access_cidrs     = var.CLUSTER_ENDPOINT_PUBLIC_ACCESS_CIDRS
    }

    tags = {
        "kubernetes.io/cluster/${var.CLUSTER_NAME}" = "shared"
    }

}
