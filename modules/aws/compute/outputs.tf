//New Config (With ALB)
output "alb_dns_name" {
  description = "DNS name of the Application Load Balancer."
  value       = aws_lb.this.dns_name
}

output "target_group_arn" {
  description = "ARN of the ALB target group."
  value       = aws_lb_target_group.this.arn
}

output "alb_security_group_id" {
  description = "Security group ID attached to the ALB."
  value       = aws_security_group.alb.id
}

output "ec2_security_group_id" {
  description = "Security group ID attached to EC2 instances."
  value       = aws_security_group.ec2.id
}

output "autoscaling_group_name" {
  description = "Name of the Auto Scaling Group."
  value       = aws_autoscaling_group.this.name
}

//Old Config (No ALB)
/*output "instance_id" {
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
}*/