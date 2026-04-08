output "load_balancer_id" {
  description = "Azure Load Balancer ID."
  value       = azurerm_lb.this.id
}

output "load_balancer_public_ip" {
  description = "Public IP address of the Azure Load Balancer."
  value       = azurerm_public_ip.lb.ip_address
}

output "vm_scale_set_id" {
  description = "Azure VM Scale Set ID."
  value       = azurerm_linux_virtual_machine_scale_set.this.id
}

output "network_security_group_id" {
  description = "Azure NSG ID for the VM Scale Set."
  value       = azurerm_network_security_group.this.id
}