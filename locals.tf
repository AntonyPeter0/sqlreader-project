locals {
  location = "North Europe"
  resource_group_name = "sql-app-rg"
  virtual_network_name = "sqlreader-vnet"
  virtual_network_address_space = "10.0.0.0/16"
  subnet_name = ["web-subnet","db-subnet"]
}
