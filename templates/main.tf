terraform {
  backend "azurerm" {}
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "=3.53.0"
    }
  }
}
provider "azurerm" {
  features {}
}


resource "azurerm_resource_group" "resource-group-01" { 
  name      = "${local.name-prefix}rg${local.name-suffix}-01" #az-sbr-cl-rg-qa-ewm
  location  = var.location

  tags = local.common-tags

  lifecycle {
    prevent_destroy = true

    ignore_changes = [ ]
  }
}


module "network" {
  source                 = "./modules/network"
  location               = azurerm_resource_group.resource-group-01.location
  resource-group-name = azurerm_resource_group.resource-group-01.name

  vnet-name   = "${local.name-prefix}vnet-qa-net" #az-sbr-cl-vnet-qa-net-01
  subnet-name = "${local.name-prefix}snet-qa-net" #az-sbr-cl-snet-qa-net-01

  nsg-name = "${local.name-prefix}nsg-vm${local.name-suffix}" #az-sbr-cl-nsg-vm-qa-ewm

  common-tags = local.common-tags
}

module "virtual-machine" {
  source = "./modules/virtual-machine"

  location               = var.location
  resource-group-name = azurerm_resource_group.resource-group-01.name

  vm-nic-name = "${local.name-prefix}nic${local.name-suffix}"
  vm-win-name       = local.vm-win-name-uppercase
  vm-admin-username = var.vm-admin-username
  vm-admin-password = var.vm-admin-password
  vm-size-01        = var.vm-size-01
  vm-image-publisher    = var.vm-image-publisher
  vm-image-offer        = var.vm-image-offer
  vm-image-sku          = var.vm-image-sku
  vm-image-version      = var.vm-image-version

  #sentinel-token = var.sentinel-token
  #nessus-group = var.nessus-group
  #nessus-server = var.nessus-server
  #nessus-key = var.nessus-key

  # Network variables
  subnet-id-01          = module.network.snet-id-01
  nsg-id-01             = module.network.nsg-id-01

  tag-environment = var.tag-environment

  common-tags = local.common-tags
  vm-tags     = local.vm-tags
}

