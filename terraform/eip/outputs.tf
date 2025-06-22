output "allocation_id" {
  description = "Elastic IP Allocation ID"
  value       = aws_eip.this.id
}

