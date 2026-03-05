provider "azurerm" {
  features {}
}

module "network" {
  source   = "../../modules/azure/network"
  name     = var.name
  location = var.location

  address_space           = var.vnet_cidr
  public_subnet_prefixes  = var.public_subnet_prefixes
  private_subnet_prefixes = var.private_subnet_prefixes
}

//Comment out until Milestone 2 implementation
/*module "compute" {
  source   = "../../modules/azure/compute"
  name     = var.name
  location = var.location

  # minimal “just enough for connection”
  subnet_id = module.network.public_subnet_ids[0]
}

module "database" {
  source            = "../../modules/azure/database"
  name              = var.name
  location          = var.location
  db_admin_username = var.db_username
  db_admin_password = var.db_password
}*/