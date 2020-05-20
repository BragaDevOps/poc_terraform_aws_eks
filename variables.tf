variable "ENVIRONMENT" {
  type        = string
  description = "Ambiente que será implantando o cluster."
}

variable "AWS_S3_TERRAFORM_BACKEND" {
  type        = string
  description = "Nome do bucket S3 que será versionado o terraform.tfstate."
}

variable "AWS_USER_DEPLOY" {
  type        = string
  description = "Nome do usuário da AWS com as credênciais para realizar o deploy."
}

variable "AWS_ACCOUNT_ID" {
  type        = string
  description = "ID da conta da AWS."
}

variable "AWS_REGION" {
  type        = string
  description = "Região da AWS que o cluster será implantado."
}

variable "AWS_PROFILE" {
  type        = string
  description = "O profile do usuário que realizará o deploy e que foi configurado em ~/.aws/credentials."
}

variable "AWS_KMS_DESCRIPTION" {
  type        = string
  description = "Nome de identificação do KMS que será criado e utilizado para criptografar e descriptografar o bucket S3."
}

variable "DOMAIN" {
  type        = string
  description = "Domiminio existente com os Servernames da AWS configurados para criar o Hosted Zone."
}

###################################################
### VPC
###################################################
variable "VPC_CIDR_BLOCK" {
  type        = string
  description = "Faixa de IPs para toda a VPC."
}

variable "VPC_INSTANCE_TENACY" {}
variable "DNS_SUPPORT" {}
variable "DNS_HOST_NAMES" {}
variable "DESTINATION_CIDR_BLOCK" {}
variable "CLUSTER_ENDPOINT_PUBLIC_ACCESS_CIDRS" {
  description = "Lista de blocos CIDR que podem acessar o terminal do servidor de API pública do Amazon EKS"
  type        = list(string)
  default     = ["0.0.0.0/0"]
}

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
variable "PRIVATE_SUBNET_AVAILABILITY_ZONE_1A" {}

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

###################################################
### Cluser k8s
###################################################
variable "CLUSTER_NAME" {
  type        = string
  description = "Nome do cluster k8s que será criado."
}

variable "K8S_VERSION" {
  type        = string
  description = "Versão do k8s que será utilizado."
}

variable "NODES_INSTANCES_SIZES" {
  type        = list(string)
  description = "Tipo de instância EC2 que será utilizado nos nodes."
}

variable "AUTO_SCALE_OPTIONS" {
  type        = map(string)
  description = "Configuração do auto scalling group para a quantidade de nodes."
}

variable "AUTO_SCALE_CPU" {
  type        = map(string)
  description = "Configuração do up e down sacalling para auto scaling group."
}
