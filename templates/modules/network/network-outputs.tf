output "vnet-id-01" { value = azurerm_virtual_network.vnet-01.id }
output "snet-id-01" { value = azurerm_subnet.snet-01.id }
output "nsg-id-01" { value = azurerm_network_security_group.nsg-01.id }