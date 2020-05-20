resource "aws_eks_node_group" "cluster" {
  
    cluster_name = var.EKS_CLUSTER.name
    node_group_name = format("%s-node-group", var.CLUSTER_NAME)
    node_role_arn = aws_iam_role.eks_nodes_roles.arn

    subnet_ids = [
        var.PRIVATE_SUBNET_1A.id,
        var.PRIVATE_SUBNET_1B.id,
        var.PRIVATE_SUBNET_2B.id
    ]

    instance_types = var.NODES_INSTANCES_SIZES

    scaling_config {
        desired_size = lookup(var.AUTO_SCALE_OPTIONS, "desired")
        max_size     = lookup(var.AUTO_SCALE_OPTIONS, "max")
        min_size     = lookup(var.AUTO_SCALE_OPTIONS, "min")
    }

    tags = {
        Name = format("%s-node", var.CLUSTER_NAME),
        "kubernetes.io/cluster/${var.CLUSTER_NAME}" = "owned"
    }

}
