resource "azurerm_linux_virtual_machine_scale_set" "vmss" {
  name                = "vmss-webapp-demo"
  location            = var.location
  resource_group_name = var.resource_group_name
  sku                 = "Standard_B2ats_v2"
  instances           = 2
  admin_username      = var.admin_username
  admin_password      = var.admin_password

  disable_password_authentication = false

  source_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-jammy"
    sku       = "22_04-lts"
    version   = "latest"
  }

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  network_interface {
    name    = "vmss-nic"
    primary = true

    ip_configuration {
      name                                   = "vmss-ip-config"
      primary                                = true
      subnet_id                              = var.web_subnet_id
      load_balancer_backend_address_pool_ids = [var.backend_pool_id]
    }
  }

  upgrade_mode = "Manual"

  tags = {
    environment = "demo"
    project     = "azure-resilient-webapp"
  }
}