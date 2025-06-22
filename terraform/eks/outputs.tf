output "eks_cluster_name" {
  description = "EKS cluster name"
  value       = aws_eks_cluster.eks_cluster.name
}

output "eks_cluster_endpoint" {
  description = "EKS cluster endpoint"
  value       = aws_eks_cluster.eks_cluster.endpoint
}

output "eks_cluster_ca_certificate" {
  description = "EKS cluster certificate authority"
  value       = aws_eks_cluster.eks_cluster.certificate_authority[0].data
}

