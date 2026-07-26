resource "azurerm_recovery_services_vault" "vault" {
  name                = "rsv-webapp-demo"
  location            = var.location
  resource_group_name = var.resource_group_name
  sku                 = "Standard"

  tags = {
    environment = "demo"
    project     = "azure-resilient-webapp"
  }
}

resource "azurerm_backup_policy_vm" "daily_policy" {
  name                = "daily-backup-policy"
  resource_group_name = var.resource_group_name
  recovery_vault_name = azurerm_recovery_services_vault.vault.name

  backup {
    frequency = "Daily"
    time      = "02:00"
  }

  retention_daily {
    count = 7
  }
}

resource "azurerm_backup_protected_vm" "mgmt_vm_backup" {
  resource_group_name = var.resource_group_name
  recovery_vault_name = azurerm_recovery_services_vault.vault.name
  source_vm_id        = var.mgmt_vm_id
  backup_policy_id    = azurerm_backup_policy_vm.daily_policy.id
}