resource "azurerm_virtual_machine_extension" "vmextension" {
  name                 = var.extension_name
  virtual_machine_id   = var.virtual_machine_id
  publisher            = var.extension_type.publisher
  type                 = var.extension_type.type
  type_handler_version = var.extension_type.type_handler_version
  
  settings = <<SETTINGS
    {
        "fileUris": ["https://${var.storage_account_name}.blob.core.windows.net/${var.container_name}/${var.script_name}"],
          "commandToExecute": "powershell -ExecutionPolicy Unrestricted -file ${var.script_name}"     
    }
SETTINGS

}
//