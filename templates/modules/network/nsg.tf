resource "azurerm_network_security_group" "nsg-01" {
  name                = "${var.nsg-name}"
  location            = var.location
  resource_group_name = var.resource-group-name

  tags = var.common-tags

  lifecycle {
    ignore_changes = [
    ]
    prevent_destroy = true
  }
}

# resource "azurerm_subnet_network_security_group_association" "nsg-subnet-association" {
#   subnet_id                 = azurerm_subnet.snet-01.id
#   network_security_group_id = azurerm_network_security_group.nsg-01.id
# }

