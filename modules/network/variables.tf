
variable "CLUSTER_NAME" {}

variable "AWS_REGION" {}

###################################################
### VPC
###################################################
variable "VPC_CIDR_BLOCK" {}

variable "VPC_INSTANCE_TENACY" {}

variable "DNS_SUPPORT" {}

variable "DNS_HOST_NAMES" {}

variable "DESTINATION_CIDR_BLOCK" {}

###################################################
### PUBLIC SUBNET 1a - us-east-1a
###################################################
variable "PUBLIC_SUBNET_CIDER_BLOCK_1A" {}

variable "PUBLIC_SUBNET_AVAILABILITY_ZONE_1A" {}

###################################################
### PUBLIC SUBNET 1b - us-east-1b
###################################################
variable "PUBLIC_SUBNET_CIDER_BLOCK_1B" {}

variable "PUBLIC_SUBNET_AVAILABILITY_ZONE_1B" {}

###################################################
### PUBLIC SUBNET 2b - us-east-1b
###################################################
variable "PUBLIC_SUBNET_CIDER_BLOCK_2B" {}

variable "PUBLIC_SUBNET_AVAILABILITY_ZONE_2B" {}

###################################################
### PRIVATE SUBNET 1a - us-east-1a
###################################################

variable "PRIVATE_SUBNET_CIDER_BLOCK_1A" {}


variable "PRIVATE_SUBNET_AVAILABILITY_ZONE_1A" {
  default = "us-east-1a"
}

###################################################
### PRIVATE SUBNET 1b - us-east-1b
###################################################

variable "PRIVATE_SUBNET_CIDER_BLOCK_1B" {}

variable "PRIVATE_SUBNET_AVAILABILITY_ZONE_1B" {}

###################################################
### PRIVATE SUBNET 2b - us-east-1b
###################################################

variable "PRIVATE_SUBNET_CIDER_BLOCK_2B" {}

variable "PRIVATE_SUBNET_AVAILABILITY_ZONE_2B" {}