##Variables for the deployment.

variable "region" {
  type        = string
  description = "Region for resource deployment"
  default     = "North Europe"
}

variable "resource_grp" {
  type        = list(string)
  description = "Resourcegroup for resource deployment"
  default     = ["az104-07-rg0", "az104-07-rg1"]
}

variable "main_nsg" {
  type        = string
  description = "Network Security Group for vnet"
  default     = "az104-05-NSG"
}

variable "vnet0" {
  type = map(object({
    vnet_name   = string
    vnet_cidr   = string
    subnet_name = string
    subnet_cidr = string
  }))
  default = {
    vnet = {
      vnet_name   = "az104-05-vnet0"
      vnet_cidr   = "10.70.0.0/22"
      subnet_name = "Subnet0"
      subnet_cidr = "10.70.0.0/24"
    }
  }
}

variable "vm_nic_01" {
  type        = string
  description = "Virtual Machine Network Interface Card"
  default     = "VM-NIC-01"
}

variable "vm_pip_01" {
  type = map(object({
    pip_name       = string
    pip_allocation = string
    sku            = string
  }))
  default = {
    pip = {
      pip_name       = "VM-PIP-01"
      pip_allocation = "Static"
      sku            = "Standard"
    }
  }
}

variable "vm_config_01" {
  type = map(object({
    vm_name     = string
    vm_size     = string
    vm_username = string
    vm_password = string
  }))
  default = {
    vm = {
      vm_name     = "Windows-VM-01"
      vm_size     = "Standard_D2_v2"
      vm_username = "kalleanka"
      vm_password = "kalleanka12345!"
    }
  }
}

variable "src_img_ref" {
  type = map(object({
    publisher = string
    offer     = string
    sku       = string
    version   = string
  }))
  default = {
    source_vm = {
      publisher = "MicrosoftWindowsServer"
      offer     = "WindowsServer"
      sku       = "2019-Datacenter"
      version   = "latest"
    }
  }
}

variable "main_storage_account" {
  type = map(object({
    sa_name                  = string
    account_tier             = string
    account_replication_type = string
  }))
  default = {
    main_sa = {
      sa_name                  = "terraformstorageacc12345"
      account_tier             = "Standard"
      account_replication_type = "GRS"
    }
  }
}

variable "main_sa_container" {
  type = map(object({
    name        = string
    access_type = string
  }))
  default = {
    main_container = {
      name        = "terraformazurecontainer"
      access_type = "blob"
    }
  }
}