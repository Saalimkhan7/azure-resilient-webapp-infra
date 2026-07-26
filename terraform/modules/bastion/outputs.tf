output "bastion_id" {
  value = azurerm_bastion_host.bastion.id
}

output "bastion_name" {
  value = azurerm_bastion_host.bastion.name
}

output "bastion_public_ip" {
  value = azurerm_public_ip.bastion_pip.ip_address
}