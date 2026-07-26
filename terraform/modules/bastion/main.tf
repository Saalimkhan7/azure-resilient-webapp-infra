resource "azurerm_public_ip" "bastion_pip" {
  name                = "pip-bastion-webapp-demo"
  location            = var.location
  resource_group_name = var.resource_group_name
  allocation_method   = "Static"
  sku                 = "Standard"

  tags = {
    environment = "demo"
    project     = "azure-resilient-webapp"
  }
}

resource "azurerm_bastion_host" "bastion" {
  name                = "bastion-webapp-demo"
  location            = var.location
  resource_group_name = var.resource_group_name
  sku                 = "Basic"

  ip_configuration {
    name                 = "bastion-ip-config"
    subnet_id            = var.bastion_subnet_id
    public_ip_address_id = azurerm_public_ip.bastion_pip.id
  }

  tags = {
    environment = "demo"
    project     = "azure-resilient-webapp"
  }
}