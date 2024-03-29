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

    depends_on = [ module.general_module,
    module.networking_module
     ]
    
}

module "compute_module" {

    source = "./modules/compute"
    resource_group_name = local.resource_group_name
    location_name = local.location
    subnet_id =  module.networking_module.output_subnet["db-subnet"].id
    private_ip_allocation_type = local.private_ip_allocation_type
    public_ip_name = local.public_ip_name
    public_ip_required = local.public_ip_required
    interface_name = local.interface_name
    vm_name = local.vm_name
    admin_username = local.admin_username
    admin_password = local.admin_password
    source_image_reference = local.source_image_reference
    depends_on = [ module.networking_module
     ]
}

resource "azurerm_mssql_virtual_machine" "mssqlmachine" {
  virtual_machine_id = module.compute_module.output__windows_vm.id
  sql_license_type   = "PAYG"
  sql_connectivity_update_password = ""
  sql_connectivity_update_username = ""
  sql_connectivity_port            = 1433
  sql_connectivity_type            = "PRIVATE"
}

module "storage_module" {

    source = "./modules/storageaccount"
    storage_account_name = local.storage_account_name
    storage_blobs = local.storage_blobs
    resource_group_name = local.resource_group_name
    location_name = local.location
    container_name = local.container_name
    blobs_enabled = true
    app_container_name = local.app_container_name
    depends_on = [ module.general_module ]
  

}

module custom_script {
  source="./modules/compute/custom-script"
  extension_name= local.extension_name
  virtual_machine_id=module.compute_module.output__windows_vm.id
  extension_type= local.extension_type
  storage_account_name= local.storage_account_name
  container_name= local.container_name
  script_name = local.script_name
  depends_on = [
    module.compute_module,
    module.storage_module
  ]
}

module "app_storage_module"{
    source="./modules/storageaccount"
    resource_group_name=local.resource_group_name
    location_name = local.location
    storage_account_name= local.storage_account_name
    container_name= local.image_container_name
    app_container_name = local.app_container_name
    storage_account_exists= true
    blobs_binary_enabled=true
    blobs_binary={
        "Laptop.jpg"="./images/"
        "Mobile.jpg"="./images/"
        "Tab.jpg"="./images/"
    }
    depends_on = [
      module.general_module
    ]
}

module "app_compute_module" {

    source = "./modules/compute"
    resource_group_name = local.resource_group_name
    location_name = local.location
    subnet_id =  module.networking_module.output_subnet["web-subnet"].id
    private_ip_allocation_type = local.private_ip_allocation_type
    public_ip_name = local.app_public_ip_name
    public_ip_required = local.app_public_ip_required
    interface_name = local.app_interface_name
    vm_name = local.app_vm_name
    admin_username = local.admin_username
    admin_password = local.admin_password
    source_image_reference = local.app_source_image_reference
    domain_name_label = local.domain_name_label
    depends_on = [ module.networking_module
     ]
}

module app_custom_script {
  source="./modules/compute/custom-script"
  extension_name= local.app_extension_name
  virtual_machine_id= module.app_compute_module.output__windows_vm.id
  extension_type= local.extension_type
  storage_account_name= local.storage_account_name
  container_name= local.container_name
  script_name = local.app_script_name
  depends_on = [
    module.app_compute_module,
    module.storage_module
  ]
}