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

resource "azurerm_network_security_group" "nsg" {

    for_each = var.network_security_group_names
    name = each.key
    location = var.location_name
    resource_group_name = var.resource_group_name

    depends_on = [ azurerm_virtual_network.network ]
  
}

resource "azurerm_subnet_network_security_group_association" "nsg-assosciation" {

    for_each = var.network_security_group_names
    subnet_id = azurerm_subnet.subnets[each.value].id
    network_security_group_id = azurerm_network_security_group.nsg[each.key].id

    depends_on = [ azurerm_virtual_network.network,
    azurerm_network_security_group.nsg ]
  
}



resource "azurerm_network_security_rule" "nsg_rule" {

        for_each = {for rule in var.nsg_rules:rule.id=>rule}
        name = "${each.value.access}-${each.value.destination_port_range}"
        priority = each.value.priority
        direction = "Inbound"
        access = each.value.access
        protocol = "Tcp"
        source_port_range = "*"
        destination_port_range = each.value.destination_port_range
        source_address_prefix = "*"
        destination_address_prefix = "*"
        resource_group_name = var.resource_group_name
        network_security_group_name = azurerm_network_security_group.nsg[each.value.network_security_group_name].name
        depends_on = [ module.general_module.output_resourcegroup,
        azurerm_virtual_network.network ]
  
}
