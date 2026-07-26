output "resource_group_name" {
  value = azurerm_resource_group.rg.name
}

output "vnet_id" {
  value = module.network.vnet_id
}

output "lb_public_ip" {
  value = module.loadbalancer.lb_public_ip
}

output "vmss_id" {
  value = module.vmss.vmss_id
}

output "storage_account_name" {
  value = module.storage.storage_account_name
}

output "mgmt_vm_name" {
  value = module.managementvm.mgmt_vm_name
}

output "vault_name" {
  value = module.backup.vault_name
}

output "log_analytics_workspace_id" {
  value = module.monitor.log_analytics_workspace_id
}

output "bastion_public_ip" {
  value = module.bastion.bastion_public_ip
}