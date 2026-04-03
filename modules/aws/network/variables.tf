variable "name" {
  type        = string
  description = "Name/prefix for network resources."
}

variable "cidr_block" {
  type        = string
  description = "CIDR block for the VPC."
}

variable "public_subnet_cidrs" {
  type = list(string)
  description = "CIDR blocks for Public Subnets"
  default = [ "10.10.1.0/24", "10.10.2.0/24" ]
}

variable "private_subnet_cidrs" {
  type = list(string)
  description = "CIDR blocks for Private Subnets"
}

variable "availability_zones" {
  type = list(string)
  description = "Availability Zones For Subnets"
  default = [ "us-west-1a", "us-west-1b" ]
}

