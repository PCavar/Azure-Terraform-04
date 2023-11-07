##Variables for the deployment, will overrider variables.tf if changed here.

region    = "North Europe"
main_nsg  = "az104-05-NSG"
vm_nic_01 = "VM-NIC-01"

resource_grp = ["az104-07-rg0", "az104-07-rg1"]

vnet0 = {
  vnet = {
    vnet_name   = "az104-05-vnet0"
    vnet_cidr   = "10.70.0.0/22"
    subnet_name = "Subnet0"
    subnet_cidr = "10.70.0.0/24"
  }
}

vm_pip_01 = {
  pip = {
    pip_name       = "VM-PIP-01"
    pip_allocation = "Static"
    sku            = "Standard"
  }
}

vm_config_01 = {
  vm = {
    vm_name     = "Windows-VM-01"
    vm_size     = "Standard_D2_v2"
    vm_username = "kalleanka"
    vm_password = "kalleanka12345!"
  }
}

src_img_ref = {
  source_vm = {
    publisher = "MicrosoftWindowsServer"
    offer     = "WindowsServer"
    sku       = "2019-Datacenter"
    version   = "latest"
  }
}

main_storage_account = {
  main_sa = {
    sa_name                  = "terraformstorageacc12345"
    account_tier             = "Standard"
    account_replication_type = "GRS"
  }
}

main_sa_container = {
  main_container = {
    name        = "terraformazurecontainer"
    access_type = "blob"
  }
}