module general_module {
    source = ".././general"
    resource_group_name = var.resource_group_name
    location_name = var.location_name
}

resource "azurerm_virtual_network" "network" {

    name = var.virtual_network_name
    location = var.location_name
    resource_group_name = var.resource_group_name
    address_space = [ var.virtual_network_address_space ]
    depends_on = [ module.general_module.output_resourcegroup ]

    }

resource "azurerm_subnet" "subnets" {
    for_each = var.subnet_name
    name = each.key
    resource_group_name = var.resource_group_name
    virtual_network_name = var.virtual_network_name
    address_prefixes = [ cidrsubnet(var.virtual_network_address_space,8,index(tolist(var.subnet_name),each.key))]
    depends_on = [ azurerm_virtual_network.network ]
  
}
  