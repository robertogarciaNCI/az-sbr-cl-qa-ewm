variable "vm-id" {}
variable "vm-kind" {}
variable "common-tags" {}

locals {
	pc_script = upper(var.vm-kind) == "WIN" ? file("${path.module}/add_local_user_account_win_v2.ps1") : file("${path.module}/bulk_create_user_v2.sh")
  base64_script = base64encode(local.pc_script)
}
