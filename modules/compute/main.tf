resource "azurerm_network_interface" "interface" {

    name = var.interface_name
    location = var.location_name
    resource_group_name = var.resource_group_name

    ip_configuration {
      name = "internal"
      subnet_id = var.subnet_id
      private_ip_address_allocation = var.private_ip_allocation_type
      public_ip_address_id = var.private_ip_allocation_type
    }
  
}

