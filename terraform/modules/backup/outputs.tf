output "vault_id" {
  value = azurerm_recovery_services_vault.vault.id
}

output "vault_name" {
  value = azurerm_recovery_services_vault.vault.name
}

output "backup_policy_id" {
  value = azurerm_backup_policy_vm.daily_policy.id
}