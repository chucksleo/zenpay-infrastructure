resource "azurerm_virtual_machine" "zenpay-vm" {
  name                  = var.vm_name
  location              = var.location
  resource_group_name   = var.resource_group_name
  network_interface_ids = [azurerm_network_interface.zenpay.id]
  vm_size               = var.vm_size

  availability_set_id = var.availability_set_id

  storage_os_disk {
    name              = var.os_disk_name
    caching           = "ReadWrite"
    create_option     = "FromImage"
    managed_disk_type = "Premium_LRS"
    disk_size_gb      = var.os_disk_size
  }

  storage_image_reference {
    publisher = "MicrosoftWindowsServer"
    offer     = "WindowsServer"
    sku       = "2019-Datacenter"
    version   = "latest"
  }

  os_profile {
    computer_name  = var.computer_name
    admin_username = var.admin_username
    admin_password = var.admin_password
  }

  os_profile_windows_config {}
}

output "vm_id" {
  value = azurerm_virtual_machine.zenpay-vm.id
}

resource "azurerm_network_interface" "zenpay" {
  name                = var.nic_name
  location            = var.location
  resource_group_name = var.resource_group_name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = var.subnet_id
    private_ip_address_allocation = "Dynamic"
  }

#   network_security_group_id = var.network_security_group_id
}

