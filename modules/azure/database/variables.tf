variable "name" {
  type        = string
  description = "Base name for Azure database resources"
}

variable "location" {
  type        = string
  description = "Azure region for database resources"
}

variable "resource_group_name" {
  type        = string
  description = "Resource group name where database resources will be created"
}

variable "db_admin_username" {
  type        = string
  description = "Admin username for Azure SQL Server"
}

variable "db_admin_password" {
  type        = string
  description = "Admin password for Azure SQL Server"
  sensitive   = true
}

variable "db_name" {
  type        = string
  description = "Azure SQL Database name"
  default     = "appdb"
}

variable "sku_name" {
  type        = string
  description = "SKU name for Azure SQL database"
  default     = "Basic"
}

