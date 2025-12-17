module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "~> 20.0"

  cluster_name    = "harbor-eks"
  cluster_version = "1.29"

  vpc_id     = var.vpc_id
  subnet_ids = var.private_subnets

  enable_irsa = true
  cluster_endpoint_public_access  = true
  cluster_endpoint_private_access = false

  eks_managed_node_groups = {
    spot = {
      instance_types = ["t3a.small"]
      capacity_type  = "SPOT"
      desired_size   = 2
      min_size       = 2
      max_size       = 2

      labels = {
        lifecycle = "spot"
        role      = "apps"
      }

      taints = {
        spot = {
          key    = "spot"
          value  = "true"
          effect = "NO_SCHEDULE"
        }
      }
    }
  }
}

output "cluster_id" { value = module.eks.cluster_id }
output "cluster_endpoint" { value = module.eks.cluster_endpoint }
output "cluster_ca_certificate" { value = module.eks.cluster_certificate_authority_data }
