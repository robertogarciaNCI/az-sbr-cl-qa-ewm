resource "azurerm_virtual_network" "vnet-01" {
  name                = "${var.vnet-name}-01" #az-sbr-cl-vnet-qa-net-01
  location            = var.location
  address_space       = local.address-space-vnet-pdn-01
  resource_group_name = var.resource-group-name

  tags = var.common-tags

  lifecycle {
    ignore_changes = [
    ]

    prevent_destroy = true
  }
}

resource "azurerm_subnet" "snet-01" {
  name                 = "${var.subnet-name}-01" #az-sbr-cl-snet-qa-net-01
  address_prefixes     = local.address-pref-snet-pdn-01
  resource_group_name  = var.resource-group-name
  virtual_network_name = azurerm_virtual_network.vnet-01.name

  lifecycle {
    ignore_changes = []

    prevent_destroy = true
  }
}