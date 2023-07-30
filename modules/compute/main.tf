resource "azurerm_network_interface" "interface" {
    
    name = var.interface_name
    location = var.location_name
    resource_group_name = var.resource_group_name

    ip_configuration {
      name = "internal"
      subnet_id = var.subnet_id
      private_ip_address_allocation = var.private_ip_allocation_type
      public_ip_address_id = try(azurerm_public_ip.ip[0].id,null) //we can pass the public ip address as null to this module.
    }

    depends_on = [ 
      azurerm_public_ip.ip
     ]
  
}

resource "azurerm_public_ip" "ip" {

  count = var.public_ip_required ? 1 : 0 // only create if required
  name = var.public_ip_name
  location = var.location_name
  resource_group_name = var.resource_group_name
  allocation_method = "Static"
  
}

resource "azurerm_windows_virtual_machine" "windows_vm" {

  name = var.vm_name
  location = var.location_name
  resource_group_name = var.resource_group_name
  size = var.size
  admin_username = var.admin_username
  admin_password = var.admin_password

  network_interface_ids = [
    azurerm_network_interface.interface.id
  ]
  
  os_disk {
    caching = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = var.source_image_reference.publisher
    offer = var.source_image_reference.offer
    sku = var.source_image_reference.sku
    version = var.source_image_reference.version
  }

  depends_on = [ azurerm_network_interface.interface ]
}
