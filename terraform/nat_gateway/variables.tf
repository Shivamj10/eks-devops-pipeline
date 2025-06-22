variable "vpc_id" {
  description = "VPC ID where NAT Gateway will be created"
  type        = string
}

variable "allocation_id" {
  description = "Elastic IP allocation ID for the NAT Gateway"
  type        = string
}

variable "public_subnet_ids" {
  description = "List of public subnet IDs"
  type        = list(string)
}
