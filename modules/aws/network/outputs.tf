output "vpc_id" {
  description = "ID of the VPC"
  value = aws_vpc.this.id
}

output "public_subnet_ids" {
  description = "ID of Public Subnets"
  value = [for s in aws_subnet.public : s.id]
}

output "private_subnet_ids" {
  description = "ID of Private Subnets"
  value = [for s in aws_subnet.private : s.id]
}