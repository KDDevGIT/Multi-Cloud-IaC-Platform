output "vm_id" {
  description = "ID of the Azure Linux VM."
  value       = azurerm_linux_virtual_machine.this.id
}

output "public_ip_address" {
  description = "Public IP address assigned to the VM."
  value       = azurerm_public_ip.this.ip_address
}

output "network_interface_id" {
  description = "NIC ID attached to the VM."
  value       = azurerm_network_interface.this.id
}