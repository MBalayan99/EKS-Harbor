##################################################
# Network Outputs
##################################################
output "vpc_id" {
  description = "VPC ID created by network module"
  value       = module.network.vpc_id
}

output "public_subnets" {
  description = "List of public subnets"
  value       = module.network.public_subnets
}

output "private_subnets" {
  description = "List of private subnets"
  value       = module.network.private_subnets
}

##################################################
# EKS Outputs
##################################################
output "eks_cluster_name" {
  description = "EKS cluster name"
  value       = module.eks.cluster_name
}

output "eks_cluster_endpoint" {
  description = "EKS cluster API endpoint"
  value       = module.eks.cluster_endpoint
}

output "eks_cluster_ca" {
  description = "EKS cluster CA certificate (base64)"
  value       = module.eks.cluster_ca
}

output "eks_node_group_names" {
  description = "Names of all EKS node groups"
  value       = module.eks.node_group_names
}

##################################################
# Harbor Outputs
##################################################
output "harbor_url" {
  description = "URL to access Harbor registry"
  value       = module.harbor.harbor_url
}

output "harbor_admin_user" {
  description = "Harbor admin username"
  value       = module.harbor.admin_user
}

output "harbor_admin_password" {
  description = "Harbor admin password"
  value       = module.harbor.admin_password
}

##################################################
# Monitoring Outputs
##################################################
output "grafana_url" {
  description = "URL to access Grafana dashboard"
  value       = module.monitoring.grafana_url
}

output "grafana_admin_user" {
  description = "Grafana admin username"
  value       = module.monitoring.admin_user
}

output "grafana_admin_password" {
  description = "Grafana admin password"
  value       = module.monitoring.admin_password
}
