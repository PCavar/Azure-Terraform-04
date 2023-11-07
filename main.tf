##Provisioning resources needed for this deployment

resource "azurerm_public_ip" "public_ip_01" {
  name                = var.vm_pip_01["pip"].pip_name
  resource_group_name = azurerm_resource_group.main_rg_1.name
  location            = azurerm_resource_group.main_rg_1.location
  allocation_method   = var.vm_pip_01["pip"].pip_allocation
  sku                 = var.vm_pip_01["pip"].sku
}

resource "azurerm_network_interface" "vm_nic_01" {
  name                = var.vm_nic_01
  location            = azurerm_resource_group.main_rg_1.location
  resource_group_name = azurerm_resource_group.main_rg_1.name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.sub.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.public_ip_01.id
  }
}

resource "azurerm_windows_virtual_machine" "vm_01" {
  name                = var.vm_config_01["vm"].vm_name
  resource_group_name = azurerm_resource_group.main_rg_1.name
  location            = azurerm_resource_group.main_rg_1.location
  size                = var.vm_config_01["vm"].vm_size
  admin_username      = var.vm_config_01["vm"].vm_username
  admin_password      = var.vm_config_01["vm"].vm_password
  network_interface_ids = [
    azurerm_network_interface.vm_nic_01.id
  ]

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = var.src_img_ref["source_vm"].publisher
    offer     = var.src_img_ref["source_vm"].offer
    sku       = var.src_img_ref["source_vm"].sku
    version   = var.src_img_ref["source_vm"].version
  }
}

resource "azurerm_storage_account" "main_storage_account" {
  name                     = var.main_storage_account["main_sa"].sa_name
  resource_group_name      = azurerm_resource_group.main_rg_2.name
  location                 = azurerm_resource_group.main_rg_2.location
  account_tier             = var.main_storage_account["main_sa"].account_tier
  account_replication_type = var.main_storage_account["main_sa"].account_replication_type
}

resource "azurerm_storage_account_network_rules" "main_storage_account_rules" {
  storage_account_id = azurerm_storage_account.main_storage_account.id
  default_action     = "Allow"
  ip_rules           = [azurerm_public_ip.public_ip_01.ip_address]
}

resource "azurerm_storage_container" "main_container" {
  name                  = var.main_sa_container["main_container"].name
  storage_account_name  = azurerm_storage_account.main_storage_account.name
  container_access_type = var.main_sa_container["main_container"].access_type
}

resource "azurerm_storage_blob" "main_blob" {
  name                   = "testingAblob.txt"
  access_tier            = "Hot"
  storage_account_name   = azurerm_storage_account.main_storage_account.name
  storage_container_name = azurerm_storage_container.main_container.name
  type                   = "Block"
  source                 = "./testingAblob.txt"
  content_type           = "text/plain"
}

resource "azurerm_storage_blob" "another_blob" {
  name                   = "aBlob"
  access_tier            = "Hot"
  storage_account_name   = azurerm_storage_account.main_storage_account.name
  storage_container_name = azurerm_storage_container.main_container.name
  type                   = "Block"
  source                 = "./aBlob.png"
  content_type           = "text/plain"
}


resource "azurerm_storage_share" "main_share" {
  name                 = "fileshareaz104"
  storage_account_name = azurerm_storage_account.main_storage_account.name
  quota                = 50
}

resource "azurerm_storage_share_directory" "main_share_directory" {
  name                 = "firstDirectory"
  share_name           = azurerm_storage_share.main_share.name
  storage_account_name = azurerm_storage_account.main_storage_account.name
}

resource "azurerm_storage_share_file" "main_file_share" {
  name             = "aFileShare"
  storage_share_id = azurerm_storage_share.main_share.id
  source           = "./aFileShare.png"
}