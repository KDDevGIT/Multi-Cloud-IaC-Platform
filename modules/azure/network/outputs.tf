output "vnet_id" {
  value = azurerm_virtual_network.this.id 
}

output "public_subnet_ids" {
    value = [for s in azurerm_subnet_public : s.id]
}

output "private_subnet_ids" {
    value = [for s in azurerm_subnet_private : s.id]
}