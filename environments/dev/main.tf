module "network" {
  source = "../../modules/network"
}

module "eks" {
  source          = "../../modules/eks"
  vpc_id          = module.network.vpc_id
  private_subnets = module.network.private_subnets
}

module "harbor" {
  source = "../../modules/harbor"

  providers = {
    kubernetes = kubernetes.eks
    helm       = helm
  }
}

module "monitoring" {
  source = "../../modules/monitoring"

  providers = {
    kubernetes = kubernetes.eks
    helm       = helm
  }
}
