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
  type = set(string)
  description = "This defines the subnets in Vnet"
  default = [ "default-subnet" ]
}

variable "network_security_group_names" {

  type = map(string)
  description = "This defines the names of  NSG "
  default = {
    "default" = "default-nsg"
  }
  
}

variable "nsg_rules" {

  type = list
  description= "These are the rules of NSG"
  default = [ {"default"="default"} ]
  
}