variable "name" {
  type = string
}

variable "location" {
  type = string
}

variable "address_space" {
  type        = list(string)
  description = "VNet CIDR(s)"
}

variable "public_subnet_prefixes" {
  type        = list(string)
  description = "CIDRs for 'public' subnets"
}

variable "private_subnet_prefixes" {
  type        = list(string)
  description = "CIDRs for 'private' subnets"
}