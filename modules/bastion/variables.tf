variable "resource_group_name" {
    type = string
    description = "This is the RG name"
}

variable "location_name" {
    type = string
    description = "This is the loaction of the Vnet"
  
}

variable "virtual_network_name" {
  type = string
  description = "This defines the name of Vnet"
}

variable "virtual_network_address_space" {
  type = string
  description = "This defines the address space of Vnet"
}

variable "subnet_name" {
  type = string
  description = "This defines the subnets in Vnet"
  default = "bastion-subnet"
}

variable "allocation_method" {
    type=string
    description = "Allocation method of IP"
    default = "Static"
}

variable "bastionip_name" {
    type=string
    description = "Name of public ip for bastion network"
    default = "bastion-ip"
}

variable "bastion_sku" {
    type=string
    description = "Name of public ip for bastion network"
    default = "Standard"
}

variable "bastion_host_name" {
    type=string
    description = "Name of name of bastion service"
    default = "appbastion"
}

variable "bastion_ip_config_name" {
    type=string
    description = "Name of name of ip config"
    default = "Bastion-ip-configuration"
}
