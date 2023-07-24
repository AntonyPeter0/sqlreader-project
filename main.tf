module "general_module" {

    source = "./modules/general"
    resource_group_name = local.resource_group_name
    location_name = local.location
  
}

module "networking_module" {

    source = "./modules/networking"
    resource_group_name = local.resource_group_name
    location_name = local.location
    virtual_network_name = local.virtual_network_name
    virtual_network_address_space = local.virtual_network_address_space
    subnet_name = local.subnet_name
    network_security_group_names = local.network_security_group_names
    nsg_rules = local.network_security_group_rules
    
  
}

module "bastion_service" {

    source = "./modules/bastion"
    resource_group_name = local.resource_group_name
    location_name = local.location
    virtual_network_name = local.virtual_network_name
    virtual_network_address_space = local.virtual_network_address_space
    
}