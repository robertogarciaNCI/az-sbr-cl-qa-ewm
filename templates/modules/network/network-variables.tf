variable "vnet-name" {}
variable "subnet-name" {}
variable "resource-group-name" {}
variable "nsg-name" {}
variable "location" {}
variable "common-tags" {}

locals {
  # VNET 01
  address-space-vnet-pdn-01 = ["10.91.63.96/27"]

  address-pref-snet-pdn-01 = ["10.91.63.96/27"]

  server-public-tcp-ports = []
  priority                = 100
}

