resource "azurerm_network_interface" "mgmt_nic" {
  name                = "nic-vm-mgmt-demo"
  location            = var.location
  resource_group_name = var.resource_group_name

  ip_configuration {
    name                          = "mgmt-ip-config"
    subnet_id                     = var.app_subnet_id
    private_ip_address_allocation = "Dynamic"
  }
}

resource "azurerm_linux_virtual_machine" "mgmt_vm" {
  name                = "vm-mgmt-demo"
  location            = var.location
  resource_group_name = var.resource_group_name
  size                = "Standard_B2ats_v2"
  admin_username      = var.admin_username
  admin_password      = var.admin_password

  disable_password_authentication = false

  network_interface_ids = [
    azurerm_network_interface.mgmt_nic.id
  ]

  source_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-jammy"
    sku       = "22_04-lts"
    version   = "latest"
  }

  os_disk {
    name                 = "disk-vm-mgmt-demo"
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  tags = {
    environment = "demo"
    project     = "azure-resilient-webapp"
  }
}