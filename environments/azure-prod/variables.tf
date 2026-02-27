variable "name" {
  type = string
}

variable "location" {
  type = string
}

variable "vnet_cidr" {
  type = list(string)
}

variable "db_username" {
  type = string
}
variable "db_password" {
  type = string
  sensitive = true
}

//Added from Azure > Network > Outputs.tf and Main.tf 
variable "public_subnet_prefixes" {
  type = list(string)
}

variable "private_subnet_prefixes" {
  type = list(string)
}