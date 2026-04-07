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
  default = "t2.micro"
}

variable "ami_id" {
  type = string
  description = "AMI ID for the EC2 Instance"
}

//Application Load Balancer Implmentation
variable "desired_capacity" {
  type = number
  description = "Desired No. of EC2 Instances"
  default = 2
}

variable "min_size" {
  type = number
  description = "Minimum No. of EC2 Instances"
  default = 2
}

variable "max_size" {
  type = number
  description = "Maximum No. of EC2 Instances"
  default = 3
}
