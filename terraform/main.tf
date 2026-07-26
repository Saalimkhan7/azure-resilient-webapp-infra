resource "azurerm_resource_group" "rg" {
  name     = var.resource_group_name
  location = var.location
}

module "network" {
  source              = "./modules/network"
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location
}

module "loadbalancer" {
  source              = "./modules/loadbalancer"
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location
}

module "vmss" {
  source              = "./modules/vmss"
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location
  admin_username      = var.admin_username
  admin_password      = var.admin_password
  web_subnet_id       = module.network.web_subnet_id
  backend_pool_id     = module.loadbalancer.backend_pool_id
}

module "storage" {
  source               = "./modules/storage"
  resource_group_name  = azurerm_resource_group.rg.name
  location             = azurerm_resource_group.rg.location
  storage_account_name = "stwebapptfdemo${random_string.suffix.result}"
}

module "managementvm" {
  source              = "./modules/managementvm"
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location
  admin_username      = var.admin_username
  admin_password      = var.admin_password
  app_subnet_id       = module.network.app_subnet_id
}

module "backup" {
  source              = "./modules/backup"
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location
  mgmt_vm_id          = module.managementvm.mgmt_vm_id
}

module "monitor" {
  source              = "./modules/monitor"
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location
  vmss_id             = module.vmss.vmss_id
}

module "bastion" {
  source              = "./modules/bastion"
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location
  bastion_subnet_id   = module.network.bastion_subnet_id
}

resource "random_string" "suffix" {
  length  = 8
  special = false
  upper   = false
}