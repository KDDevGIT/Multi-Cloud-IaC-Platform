output "resource_group_name" {
  description = "Resource group name for Azure network resources."
  value       = azurerm_resource_group.this.name
}

output "vnet_id" {
  value = azurerm_virtual_network.this.id
}

output "public_subnet_ids" {
  value = [for s in azurerm_subnet.public : s.id]
}

output "private_subnet_ids" {
  value = [for s in azurerm_subnet.private : s.id]
}