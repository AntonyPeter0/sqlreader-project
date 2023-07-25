locals {
  location = "North Europe"
  resource_group_name = "sql-app-rg"
  virtual_network_name = "sqlreader-vnet"
  virtual_network_address_space = "10.0.0.0/16"
  subnet_name = ["web-subnet","db-subnet"]
  network_security_group_names = { 
    "web-nsg" = "web-subnet",
    "db-nsg"= "db-subnet" }

  network_security_group_rules=[
  {
      id=1,
      priority="200",
      network_security_group_name="web-nsg"
      destination_port_range="3389"
      access="Allow"
  },
  {
      id=2,
      priority="300",
      network_security_group_name="web-nsg"
      destination_port_range="80"
      access="Allow"
  },
  {
      id=3,
      priority="400",
      network_security_group_name="web-nsg"
      destination_port_range="8172"
      access="Allow"
  },
  {
      id=4,
      priority="200",
      network_security_group_name="db-nsg"
      destination_port_range="3389"
      access="Allow"
  }
  ]
}
