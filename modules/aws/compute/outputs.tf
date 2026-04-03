output "instance_id" {
  description = "ID of the EC2 Instance"
  value = aws_instance.this.id 
}

output "public_ip" {
  description = "Public IP of the EC2 Instance"
  value = aws_instance.this.public_ip
}

output "security_group_id" {
  description = "Security Group ID attached to EC2 Instance"
  value = aws_security_group.this.id 
}