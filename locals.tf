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

  private_ip_allocation_type = "Dynamic"
  public_ip_name = "app-ip"
  app_public_ip_name ="web-ip"
  public_ip_required = false
  app_public_ip_required = true
  interface_name = "db-interface"
  app_interface_name = "db-interface"
  vm_name = "db-vm"
  app_vm_name = "web-vm"
  admin_username = "AntonyPeter"
  admin_password = "Admin@123"

  source_image_reference = {
    publisher = "MicrosoftSQLServer",
    offer = "sql2019-ws2019",
    sku = "sqldev",
    version = "15.0.220510",
  }

  app_source_image_reference = {
    publisher = "MicrosoftWindowsServer",
    offer = "WindowsServer",
    sku = "2019-Datacenter",
    version = "latest",
  }
  container_name = "scripts"
  storage_blobs = {
    "01.sql" = "./dbscripts"
    "Script.ps1" = "./scripts"
  }
  storage_account_name = "appstorerandom12345num"
  app_container_name = "images"


  extension_name="dbvm-extension"
  extension_type={
  publisher            = "Microsoft.Compute"
  type                 = "CustomScriptExtension"
  type_handler_version = "1.10"
  }

 image_container_name = "images"    
}


//Created by Antony