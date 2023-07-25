# module networking_module {
#     source = ".././networking"
#     resource_group_name = var.resource_group_name
#     location_name = var.location_name
#     virtual_network_name = var.virtual_network_name
#     virtual_network_address_space = var.virtual_network_address_space
    
# #     network_security_group_names = { 
# #     "web-nsg" = "web-subnet",
# #     "db-nsg"= "db-subnet" }
# #     subnet_name = ["web-subnet","db-subnet"]
# #     nsg_rules = [
# #   {
# #       id=1,
# #       priority="200",
# #       network_security_group_name="web-nsg"
# #       destination_port_range="3389"
# #       access="Allow"
# #   },
# #   {
# #       id=2,
# #       priority="300",
# #       network_security_group_name="web-nsg"
# #       destination_port_range="80"
# #       access="Allow"
# #   },
# #   {
# #       id=3,
# #       priority="400",
# #       network_security_group_name="web-nsg"
# #       destination_port_range="8172"
# #       access="Allow"
# #   },
# #   {
# #       id=4,
# #       priority="200",
# #       network_security_group_name="db-nsg"
# #       destination_port_range="3389"
# #       access="Allow"
# #   }
# #   ]
# }

# module general_module {
#     source = ".././general"
#     resource_group_name = var.resource_group_name
#     location_name = var.location_name
# }


resource "azurerm_subnet" "basiton_subnet" {
    
    name = var.subnet_name
    resource_group_name = var.resource_group_name
    virtual_network_name = var.virtual_network_name
    address_prefixes = [ cidrsubnet(var.virtual_network_address_space,8,10)]
    # depends_on = [module.networking_module.output_virtual_network ]

}

resource "azurerm_public_ip" "bastionip" {

    name= var.bastionip_name
    resource_group_name = var.resource_group_name
    location = var.location_name
    allocation_method = var.allocation_method
    sku = var.bastion_sku

    # depends_on = [ module.general_module.output_resourcegroup ]
  
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
  
}