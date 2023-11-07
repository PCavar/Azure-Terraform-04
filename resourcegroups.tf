##Provisioning resource-groups for this Deployment.

resource "azurerm_resource_group" "main_rg_1" {
  name     = var.resource_grp[0]
  location = var.region
}

resource "azurerm_resource_group" "main_rg_2" {
  name     = var.resource_grp[1]
  location = var.region
}