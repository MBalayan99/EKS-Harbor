##################################################
# AWS Provider
# Configure AWS region for all resources
##################################################
provider "aws" {
  region = "us-east-1"
}

##################################################
# Get EKS cluster info and authentication
##################################################
# Retrieve cluster endpoint and CA
data "aws_eks_cluster" "this" {
  name = module.eks.cluster_name
}

# Get authentication token for Kubernetes provider
data "aws_eks_cluster_auth" "this" {
  name = module.eks.cluster_name
}

##################################################
# Kubernetes Provider
# Connect Terraform to the EKS cluster
##################################################
provider "kubernetes" {
  alias                  = "eks"  # alias for modules to reference
  host                   = data.aws_eks_cluster.this.endpoint
  cluster_ca_certificate = base64decode(data.aws_eks_cluster.this.certificate_authority[0].data)
  token                  = data.aws_eks_cluster_auth.this.token
}

##################################################
# Helm Provider
# Use the same EKS cluster for Helm deployments
##################################################
provider "helm" {
  kubernetes = kubernetes.eks  # reference the Kubernetes provider alias
}

