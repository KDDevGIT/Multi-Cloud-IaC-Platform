terraform {
  backend "azurerm" {
    resource_group_name = "platform-rg" 
    storage_account_name = "platformstoragekdtest" 
    container_name = "tfstatecontainerkd"
    key = "azure-prod.terraform.tfstate"
  }
}