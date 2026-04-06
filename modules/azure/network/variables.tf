variable "name" {
  type = string
}

variable "location" {
  type = string
}

variable "address_space" {
  type        = list(string)
  description = "VNet CIDR(s), e.g. [\"10.20.0.0/16\"]."
}

variable "public_subnet_prefixes" {
  type        = list(string)
  description = "CIDRs for 'public' subnets by convention."
}

variable "private_subnet_prefixes" {
  type        = list(string)
  description = "CIDRs for 'private' subnets by convention."
}