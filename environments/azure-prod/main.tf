provider "azurerm" {
  features {}
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

//Added from Azure > Network > Outputs.tf and Main.terraform 
module "network" {
  source   = "../../modules/azure/network"
  name     = var.name
  location = var.location

  address_space           = var.vnet_cidr
  public_subnet_prefixes  = var.public_subnet_prefixes
  private_subnet_prefixes = var.private_subnet_prefixes
}