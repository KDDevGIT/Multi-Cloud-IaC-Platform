variable "name" {
  type = string
}

variable "aws_region" {
  type = string
}

variable "vpc_cidr" {
  type = string
}

variable "ami_id" {
  type        = string
  description = "AMI ID for the EC2 instance."
}

variable "db_username" {
  type = string
}

variable "db_password" {
  type      = string
  sensitive = true
}