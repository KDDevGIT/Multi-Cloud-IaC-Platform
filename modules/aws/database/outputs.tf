output "db_instance_id" {
  description = "RDS instance ID."
  value       = aws_db_instance.this.id
}

output "db_endpoint" {
  description = "RDS endpoint."
  value       = aws_db_instance.this.endpoint
}

output "db_security_group_id" {
  description = "Security group attached to RDS."
  value       = aws_security_group.this.id
}