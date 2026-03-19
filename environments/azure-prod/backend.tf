terraform {
  backend "azurerm" {
    resource_group_name = "TFSTATE_NAME_RG" 
    storage_account_name = "TF_STATE_STORAGE" 
    container_name = "tfstate"
    key = "azure-prod.terraform.tfstate"
  }
}