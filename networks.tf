##Provisioning the neccessary Virtual network and Subnet needed.

resource "azurerm_virtual_network" "vnet0_main" {
  name                = var.vnet0["vnet"].vnet_name
  resource_group_name = azurerm_resource_group.main_rg_1.name
  location            = azurerm_resource_group.main_rg_1.location
  address_space       = [var.vnet0["vnet"].subnet_cidr]
}

resource "azurerm_subnet" "sub" {
  name                 = var.vnet0["vnet"].subnet_name
  resource_group_name  = azurerm_resource_group.main_rg_1.name
  virtual_network_name = azurerm_virtual_network.vnet0_main.name
  address_prefixes     = [var.vnet0["vnet"].subnet_cidr]
}