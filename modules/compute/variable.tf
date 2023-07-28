variable "interface_name" {

    type = string
    description = "This is the n/w interface name"
  
}

variable "resource_group_name" {
    type = string
    description = "This is the RG name"
}

variable "location_name" {
    type = string
    description = "This is the loaction of the Vnet"
  
}

variable "subnet_id" {
    type = string
    description = "This is the subnet id"
  
}

variable "private_ip_allocation_type" {
    type = string
    description = "This is the private_ip_allocation_type"
  
}
