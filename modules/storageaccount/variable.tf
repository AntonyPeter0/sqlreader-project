variable "storage_account_name" {
  type = string
  description = "Name of storage account"
}

variable "resource_group_name" {
    type = string
    description = "This is the RG name"
}

variable "location_name" {
    type = string
    description = "This is the location t"
  
}

variable "container_name" {
    type = string
    description = "This is the container name"
  
}

variable "app_container_name" {
    type = string
    description = "This is the container name for the application"
  
}

variable "container_access_type" {
    type = string
    description = "This is the container access type"
    default = "blob"
  
}

variable "storage_blobs" {
    type = map
    description = "This is the name of  storage blob "
  
}

variable "DatabaseName" {

   type = string
    description = "This is the data base name to be created in the server  "
    default = "app-db" 
  
}