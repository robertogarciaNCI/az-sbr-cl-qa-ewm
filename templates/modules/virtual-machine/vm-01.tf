resource "azurerm_network_interface" "vm-nic-01" {
  name                = "${var.vm-nic-name}-01"
  location            = var.location
  resource_group_name = var.resource-group-name

  ip_configuration {
    name                          = "ipconfig1"
    subnet_id                     = var.subnet-id-01
    private_ip_address_allocation = "Dynamic"
  }

  tags = var.common-tags

  lifecycle {
    ignore_changes = []

    prevent_destroy = false
  }
}

resource "azurerm_windows_virtual_machine" "vm-01" {
  name                = "${var.vm-win-name}01"
  resource_group_name = var.resource-group-name
  location            = var.location
  size                = var.vm-size-01
  admin_username      = var.vm-admin-username
  admin_password      = var.vm-admin-password

  network_interface_ids = [
    azurerm_network_interface.vm-nic-01.id
  ]

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "StandardSSD_LRS"
    disk_size_gb         = 256

  }

  source_image_reference {
    publisher = var.vm-image-publisher
    offer     = var.vm-image-offer
    sku       = var.vm-image-sku
    version   = var.vm-image-version
  }

  identity {
    type = "SystemAssigned"
  }

  patch_mode = "Manual"
  enable_automatic_updates = false

  tags = var.vm-tags

  lifecycle {
    ignore_changes = []

    prevent_destroy = false
  }
}


resource "azurerm_network_interface_security_group_association" "nsg-nic-association" {
  network_interface_id      = azurerm_network_interface.vm-nic-01.id
  network_security_group_id = var.nsg-id-01
}