variable "name" {
  type        = string
  description = "Name/prefix for network resources."
}

variable "cidr_block" {
  type        = string
  description = "CIDR block for the VPC."
}