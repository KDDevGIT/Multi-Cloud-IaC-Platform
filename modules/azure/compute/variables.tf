variable "name" {
  type        = string
  description = "Base name for Azure compute resources."
}

variable "location" {
  type        = string
  description = "Azure region for compute resources."
}

variable "resource_group_name" {
  type        = string
  description = "Resource group name where compute resources will be created."
}

variable "subnet_id" {
  type        = string
  description = "Subnet ID where the NIC/VM will be placed."
}

variable "vm_size" {
  type        = string
  description = "Azure VM size."
  default     = "Standard_B1s"
}

variable "admin_username" {
  type        = string
  description = "Admin username for the Linux VM."
}

variable "ssh_public_key" {
  type        = string
  description = "SSH public key for the Linux VM."
}