module "project-config" {
  source = "./modules/project-config"

  ENVIRONMENT = var.ENVIRONMENT

  AWS_ACCOUNT_ID = var.AWS_ACCOUNT_ID
  AWS_PROFILE    = var.AWS_PROFILE
  AWS_REGION     = var.AWS_REGION

  AWS_KMS_DESCRIPTION = var.AWS_KMS_DESCRIPTION
  AWS_USER_DEPLOY     = var.AWS_USER_DEPLOY

  AWS_S3_TERRAFORM_BACKEND = var.AWS_S3_TERRAFORM_BACKEND

  DOMAIN = var.DOMAIN
}

module "network" {
  source = "./modules/network"

  CLUSTER_NAME = var.CLUSTER_NAME
  AWS_REGION   = var.AWS_REGION

  ###################################################
  ### VPC
  ###################################################
  VPC_CIDR_BLOCK         = var.VPC_CIDR_BLOCK
  VPC_INSTANCE_TENACY    = var.VPC_INSTANCE_TENACY
  DNS_SUPPORT            = var.DNS_SUPPORT
  DNS_HOST_NAMES         = var.DNS_HOST_NAMES
  DESTINATION_CIDR_BLOCK = var.DESTINATION_CIDR_BLOCK

  ###################################################
  ### SUBNETS
  ###################################################
  PUBLIC_SUBNET_CIDER_BLOCK_1A       = var.PUBLIC_SUBNET_CIDER_BLOCK_1A
  PUBLIC_SUBNET_AVAILABILITY_ZONE_1A = var.PUBLIC_SUBNET_AVAILABILITY_ZONE_1A
  PUBLIC_SUBNET_CIDER_BLOCK_1B       = var.PUBLIC_SUBNET_CIDER_BLOCK_1B
  PUBLIC_SUBNET_AVAILABILITY_ZONE_1B = var.PUBLIC_SUBNET_AVAILABILITY_ZONE_1B
  PUBLIC_SUBNET_CIDER_BLOCK_2B       = var.PUBLIC_SUBNET_CIDER_BLOCK_2B
  PUBLIC_SUBNET_AVAILABILITY_ZONE_2B = var.PUBLIC_SUBNET_AVAILABILITY_ZONE_2B

  PRIVATE_SUBNET_CIDER_BLOCK_1A       = var.PRIVATE_SUBNET_CIDER_BLOCK_1A
  PRIVATE_SUBNET_AVAILABILITY_ZONE_1A = var.PRIVATE_SUBNET_AVAILABILITY_ZONE_1A
  PRIVATE_SUBNET_CIDER_BLOCK_1B       = var.PRIVATE_SUBNET_CIDER_BLOCK_1B
  PRIVATE_SUBNET_AVAILABILITY_ZONE_1B = var.PRIVATE_SUBNET_AVAILABILITY_ZONE_1B
  PRIVATE_SUBNET_CIDER_BLOCK_2B       = var.PRIVATE_SUBNET_CIDER_BLOCK_2B
  PRIVATE_SUBNET_AVAILABILITY_ZONE_2B = var.PRIVATE_SUBNET_AVAILABILITY_ZONE_2B

}

module "eks" {
  source = "./modules/eks"

  CLUSTER_NAME = var.CLUSTER_NAME
  AWS_REGION   = var.AWS_REGION
  K8S_VERSION  = var.K8S_VERSION

  CLUSTER_VPC       = module.network.cluster_vpc
  PRIVATE_SUBNET_1A = module.network.private_subnet_1a
  PRIVATE_SUBNET_1B = module.network.private_subnet_1b
  PRIVATE_SUBNET_2B = module.network.private_subnet_2b

  EKS_CLUSTER    = module.eks.eks_cluster
  EKS_CLUSTER_SG = module.eks.security_group

  NODES_INSTANCES_SIZES = var.NODES_INSTANCES_SIZES
  AUTO_SCALE_OPTIONS    = var.AUTO_SCALE_OPTIONS

  AUTO_SCALE_CPU = var.AUTO_SCALE_CPU

  CLUSTER_ENDPOINT_PUBLIC_ACCESS_CIDRS = var.CLUSTER_ENDPOINT_PUBLIC_ACCESS_CIDRS
}