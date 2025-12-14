
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
}

module "monitoring" {
  source = "../../modules/monitoring"
}
