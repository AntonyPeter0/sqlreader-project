resource "azurerm_subnet" "basiton_subnet" {
    
    name = var.subnet_name
    resource_group_name = var.resource_group_name
    virtual_network_name = var.virtual_network_name
    address_prefixes = [ cidrsubnet(var.virtual_network_address_space,8,10)]

}

resource "azurerm_public_ip" "bastionip" {

    name= var.bastionip_name
    resource_group_name = var.resource_group_name
    location = var.location_name
    allocation_method = var.allocation_method
    sku = var.bastion_sku
  
}

resource "azurerm_bastion_host" "appbastion" {

    name = var.bastion_host_name
    location = var.location_name
    resource_group_name = var.resource_group_name

    ip_configuration {
      name = var.bastion_ip_config_name
      subnet_id = azurerm_subnet.basiton_subnet.id
      public_ip_address_id = azurerm_public_ip.bastionip.id
    }

    depends_on = [ azurerm_public_ip.bastionip,
    azurerm_subnet.basiton_subnet ]
  
}