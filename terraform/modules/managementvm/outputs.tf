output "mgmt_vm_id" {
  value = azurerm_linux_virtual_machine.mgmt_vm.id
}

output "mgmt_vm_name" {
  value = azurerm_linux_virtual_machine.mgmt_vm.name
}

output "mgmt_vm_private_ip" {
  value = azurerm_network_interface.mgmt_nic.private_ip_address
}