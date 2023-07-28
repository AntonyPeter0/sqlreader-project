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
