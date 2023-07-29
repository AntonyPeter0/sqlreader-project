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
    default = "Dynamic"
  
}

variable "public_ip_name" {

    type = string
    description = "This is the public ip name"
}

variable "public_ip_required" {

    type = bool
    description = "Toggle to create public ip"
}

variable "vm_name" {
    type = string
    description = "Name of VM to be created"
}

variable "size" {
    type = string
    description = "Size of VM to be created"
    default = "Standard_D2s_v3"
}

variable "admin_username" {
    type = string
    description = "Username for VM"
    default = "User12345"
}

variable "admin_password" {
    type = string
    description = "Password for VM, please change once login if using default"
    default = "Pass@1234"
}

variable "source_image_reference" {

    type = map
    description = "Defines source image reference"
  
}

