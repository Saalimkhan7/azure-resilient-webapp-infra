output "vnet_id" {
  value = azurerm_virtual_network.vnet.id
}

output "web_subnet_id" {
  value = azurerm_subnet.web.id
}

output "app_subnet_id" {
  value = azurerm_subnet.app.id
}

output "mgmt_subnet_id" {
  value = azurerm_subnet.mgmt.id
}

output "bastion_subnet_id" {
  value = azurerm_subnet.bastion.id
}