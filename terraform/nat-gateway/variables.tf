variable "public_subnet_id" {
  description = "Public subnet ID where NAT Gateway will be deployed"
}

variable "project_name" {}

variable "igw_id" {
  description = "Internet Gateway ID to ensure dependency"
}

