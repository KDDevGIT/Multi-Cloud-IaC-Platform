terraform {
  backend "azurerm" {
    resource_group_name = "TFSTATE_NAME_RG" //omitted for security
    storage_account_name = "TF_STATE_STORAGE" //omitted for security
    container_name = "tfstate"
    key = "azure-prod.terraform.tfstate"
  }
}