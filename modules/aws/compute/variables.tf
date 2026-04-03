variable "name" {
  type = string
  description = "Base name for compute resources"
}

variable "vpc_id" {
  type = string
  description = "VPC ID where compute resources will be deployed"
}

variable "public_subnets" {
  type = list(string)
  description = "List of public subnet IDs"
}

variable "instance_type" {
  type = string
  description = "EC2 Instance Type"
}

variable "ami_id" {
  type = string
  description = "AMI ID for the EC2 Instance"
}