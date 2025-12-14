# EKS + Harbor + ALB + TLS + Monitoring (Terraform)

This repository provisions a **production-ready Kubernetes platform on AWS** using Terraform.

The project deploys:
- An Amazon EKS cluster using official Terraform modules
- Spot-based worker nodes for cost optimization
- Harbor container registry via Helm
- HTTPS using AWS ALB + cert-manager (Let's Encrypt)
- Monitoring with Prometheus and Grafana

---

## 🏗 Architecture Overview

- **VPC**
  - Public subnets (ALB)
  - Private subnets (EKS worker nodes)
- **EKS**
  - Managed Node Groups
  - 2 × Spot instances (`t3a.small`)
- **AWS Load Balancer Controller**
- **cert-manager**
  - Let's Encrypt ClusterIssuer
- **Harbor**
  - Deployed via Helm
  - Exposed through ALB Ingress
  - HTTPS enabled
- **Monitoring**
  - Prometheus
  - Grafana
  - Alertmanager

---

## 📁 Project Structure

.
├── environments
│   └── dev
│       ├── main.tf          # Root Terraform configuration
│       ├── providers.tf    # AWS, Kubernetes, Helm providers
│       ├── versions.tf     # Provider and Terraform versions
│       └── outputs.tf      # Useful outputs
│
├── modules
│   ├── network
│   │   ├── main.tf         # VPC, subnets, NAT Gateway
│   │   └── variables.tf
│   │
│   ├── eks
│   │   ├── main.tf         # EKS cluster and node groups
│   │   └── variables.tf
│   │
│   ├── harbor
│   │   └── main.tf         # Harbor Helm release
│   │
│   └── monitoring
│       └── main.tf         # Prometheus + Grafana Helm release
│
├── helm-values
│   ├── harbor-values.yaml      # Harbor configuration
│   └── monitoring-values.yaml # Monitoring configuration
│
└── README.md

⚙️ Prerequisites

AWS account

IAM user/role with permissions:

EKS

EC2

VPC

IAM

ELB

Installed locally:

Terraform >= 1.6

AWS CLI

kubectl

Helm

Configure AWS credentials:

aws configure

🚀 How to Deploy
1️⃣ Go to the Terraform root directory

⚠️ IMPORTANT
Terraform commands must be run from:

cd environments/dev


This is the root module.

2️⃣ Initialize Terraform
terraform init


This will:

Download Terraform providers

Download Terraform modules

Initialize backend

3️⃣ Review the plan
terraform plan

4️⃣ Apply the infrastructure
terraform apply


Type yes when prompted.

⏱️ Deployment time: 15–25 minutes

🔍 What Gets Created
EKS

Kubernetes version: 1.29

2 Spot worker nodes

Instance type: t3a.small

Labels:

lifecycle = "spot"
role      = "apps"


Taints:

spot=true:NoSchedule

Networking

VPC with public and private subnets

NAT Gateway for private subnets

Harbor

Deployed via Helm

Exposed using Ingress

HTTPS enabled

Metrics enabled

Monitoring

kube-prometheus-stack

Prometheus

Grafana

🌐 Accessing the Cluster
Update kubeconfig
aws eks update-kubeconfig \
  --region us-east-1 \
  --name harbor-eks


Verify:

kubectl get nodes

🌍 Accessing Applications
Harbor
https://harbor.armguardians.org


ALB is internet-facing
Worker nodes remain private

Grafana
kubectl get svc -n monitoring


Default credentials (unless overridden):

admin / prom-operator

🔐 Is the Cluster Public?

❓ Is the EKS cluster accessible from the internet?

✔️ Control plane endpoint: Public (default AWS behavior)
❌ Worker nodes: Private
✔️ Application access: Through ALB only

✅ This is AWS recommended best practice

🧹 Destroy Everything
terraform destroy