##Creating a NSG and opening port 3389 TCP for RDP for blob access testing

resource "azurerm_network_security_group" "nsg" {
  name                = var.main_nsg
  location            = azurerm_resource_group.main_rg_1.location
  resource_group_name = azurerm_resource_group.main_rg_1.name

  security_rule {
    name                       = "allowRDP"
    priority                   = 100
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "3389"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }
}

resource "azurerm_subnet_network_security_group_association" "subnet0_nsg" {
  subnet_id                 = azurerm_subnet.sub.id
  network_security_group_id = azurerm_network_security_group.nsg.id
}
