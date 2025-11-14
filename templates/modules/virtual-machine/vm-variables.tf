### Core variables ###
variable "location" {}

### Virtual Machine variables ###
variable "vm-nic-name" {}
variable "resource-group-name" {}
variable "vm-win-name" {}
variable "vm-admin-username" {}
variable "vm-admin-password" {}

variable "vm-size-01" {}

variable "vm-image-publisher" {}
variable "vm-image-offer" {}
variable "vm-image-sku" {}
variable "vm-image-version" {}


#Disks Variables

### Network variables ###
variable "subnet-id-01" {}
variable "nsg-id-01" {}

### Agents variables ###
#variable "sentinel-token" {}
#variable "nessus-group" {}
#variable "nessus-server" {}
#variable "nessus-key" {}

### Tag variables ###
variable "tag-environment" {}

variable "common-tags" {}
variable "vm-tags" {}