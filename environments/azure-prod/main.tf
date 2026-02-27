provider "azurerm" {
  features {}
}

module "network" {
  source = "../../modules/azure/network"
  name = var.name
  location = var.location
  address_space = var.vnet_cidr
}

module "compute" {
  source = "../../modules/azure/compute"
  name = var.name
  location = var.location
  address_space = var.network.subnet_id
}

module "database" {
  source = "../../modules/azure/database"
  name = var.name
  location = var.location
  db_admin_username = var.db_username 
  db_admin_password = var.db_password 
}