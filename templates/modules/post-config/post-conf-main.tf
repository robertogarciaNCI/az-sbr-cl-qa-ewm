resource "random_string" "rand_str" {
  length  = 5
  upper   = true
  lower   = true
  numeric = true
  special = false 
}

resource "azurerm_virtual_machine_extension" "vm-xtn-lin" {
  count                = upper(var.vm-kind) == "LIN" ? 1 : 0
  name                 = "vm-post-config-${random_string.rand_str.result}"
  virtual_machine_id   = var.vm-id
  publisher            = "Microsoft.Azure.Extensions"
  type                 = "CustomScript"
  type_handler_version = "2.1"

  protected_settings   = <<SETTINGS
 {
  "script": "${local.base64_script}"
 }
SETTINGS


  tags = var.common-tags
  
  lifecycle {
    ignore_changes = all 
  }
}

resource "azurerm_virtual_machine_extension" "vm-xtn-win" {
  count                = upper(var.vm-kind) == "WIN" ? 1 : 0
  name                 = "vm-post-config-${random_string.rand_str.result}"
  virtual_machine_id   = var.vm-id
  publisher            = "Microsoft.Compute"
  type                 = "CustomScriptExtension"
  type_handler_version = "1.9"

  protected_settings   = <<SETTINGS
  {
    "commandToExecute":"powershell -command \"[System.Text.Encoding]::UTF8.GetString([System.Convert]::FromBase64String('${local.base64_script}')) | Out-File -filepath add_local_user_account_win_v2.ps1\" && powershell -ExecutionPolicy Unrestricted -File add_local_user_account_win_v2.ps1"
  }
SETTINGS

  tags = var.common-tags

  lifecycle {
    ignore_changes = all 
  }
}
