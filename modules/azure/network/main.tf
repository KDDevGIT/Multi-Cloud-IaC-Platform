resource "azurerm_resource_group" "this" {
  name     = "${var.name}-rg"
  location = var.location
}

resource "azurerm_virtual_network" "this" {
  name                = "${var.name}-vnet"
  location            = azurerm_resource_group.this.location
  resource_group_name = azurerm_resource_group.this.name
  address_space       = var.address_space
}

resource "azurerm_subnet" "public" {
  count                = length(var.public_subnet_prefixes)
  name                 = "${var.name}-public-${count.index}"
  resource_group_name  = azurerm_resource_group.this.name
  virtual_network_name = azurerm_virtual_network.this.name
  address_prefixes     = [var.public_subnet_prefixes[count.index]]
}

resource "azurerm_subnet" "private" {
  count                = length(var.private_subnet_prefixes)
  name                 = "${var.name}-private-${count.index}"
  resource_group_name  = azurerm_resource_group.this.name
  virtual_network_name = azurerm_virtual_network.this.name
  address_prefixes     = [var.private_subnet_prefixes[count.index]]
}