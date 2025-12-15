variable "vpc_id" {
  description = "VPC ID for EKS"
  type        = string
}

variable "private_subnets" {
  description = "Private subnet IDs"
  type        = list(string)
}

