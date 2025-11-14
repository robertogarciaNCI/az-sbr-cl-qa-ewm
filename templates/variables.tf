### Core variables ###
variable "location" {}

variable "resource-group-01" {}
### Network variables ###
variable "vnet-01" {}
variable "snet-01" {}
variable "vm-country" {}
variable "resource-group-name" {}

### Virtual Machine variables ###
variable "vm-admin-username" {}
variable "vm-admin-password" {}

variable "vm-size-01" {}

variable "vm-image-publisher" {}
variable "vm-image-offer" {}
variable "vm-image-sku" {}
variable "vm-image-version" {}
variable "vm-db-image-publisher" {}
variable "vm-db-image-offer" {}
variable "vm-db-image-sku" {}
variable "vm-db-image-version" {}

variable "vm-type" {}

### Mssql variables ###
variable "mssql-admin-username" {}
variable "mssql-admin-pass" {}
variable "mssql-db-collation" {}

### Agents variables ###
variable "sentinel-token" {}
variable "nessus-group" {}
variable "nessus-server" {}
variable "nessus-key" {}

### Name concatenation variables ###
variable "project-short-description" {}

### Tags variables ###
variable "tag-cloud" { default = "Azure" }
variable "tag-country" {}
variable "tag-market" {}
variable "tag-platform" {}
variable "tag-department" {}
variable "tag-environment" {}
variable "tag-geographic-location" {}
variable "tag-project-description" {}
variable "tag-project-name" {}
variable "tag-project-owner" {}
variable "tag-solution-name" {}
variable "tag-cost-center" {}
variable "deployed-by" {}
variable "tag-deployed-date" {}
variable "tag-roledescription" {}
variable "tag-usecase" {}
variable "created-manually" { default = "false" }

locals {
  cloud-abbreviation     = "az"
  name-prefix            = "${local.cloud-abbreviation}-${var.tag-geographic-location}-${var.tag-country}-"
  name-suffix           = "-${var.tag-environment}-${var.project-short-description}"
  name-prefix-global     = "${local.cloud-abbreviation}-${var.tag-geographic-location}-gl-"
  name-no-hypens-prefix  = "${local.cloud-abbreviation}${var.tag-geographic-location}${var.tag-country}"
  name-no-hyphens-suffix = "${var.tag-environment}${var.project-short-description}"
  name-hypens-prefix     = "${local.cloud-abbreviation}-${var.tag-geographic-location}-${var.tag-country}-"
  name-hyphens-suffix    = "${var.tag-environment}-${var.project-short-description}"
  env-abbreviation       = var.tag-environment == "dev" ? "d" : (var.tag-environment == "qa" ? "q" : "p")

  # Virtual machine naming convention variables
  vm-os-lin-abbreviation = "lin"
  vm-os-win-abbreviation = "win"
  vm-lin-name-uppercase  = upper("${local.cloud-abbreviation}${var.vm-type}${var.vm-country}${local.vm-os-lin-abbreviation}${local.env-abbreviation}${var.project-short-description}")
  vm-win-name-uppercase  = upper("${local.cloud-abbreviation}${var.vm-type}${var.vm-country}${local.vm-os-win-abbreviation}${local.env-abbreviation}${var.project-short-description}")


  common-tags = {
    cloud               = var.tag-cloud
    country             = upper(var.tag-country)
    market              = upper(var.tag-market)
    platform            = var.tag-platform
    department          = var.tag-department
    environment         = var.tag-environment
    geographic_location = var.tag-geographic-location
    project_description = var.tag-project-description
    project_name        = var.tag-project-name
    project_owner       = var.tag-project-owner
    cost_center         = var.tag-cost-center
    deployed_by         = var.deployed-by
    created_manually    = var.created-manually
    deployed_date       = var.tag-deployed-date
    usecase             = var.tag-usecase
    roledescription     = var.tag-roledescription
  }

  vm-tags = {
    cloud               = var.tag-cloud
    country             = upper(var.tag-country)
    market              = upper(var.tag-market)
    platform            = var.tag-platform
    department          = var.tag-department
    environment         = var.tag-environment
    geographic_location = var.tag-geographic-location
    project_description = var.tag-project-description
    project_name        = var.tag-project-name
    project_owner       = var.tag-project-owner
    solution_name       = var.tag-solution-name
    cost_center         = var.tag-cost-center
    deployed_by         = var.deployed-by
    created_manually    = var.created-manually
    deployed_date       = var.tag-deployed-date
    usecase             = var.tag-usecase
    roledescription     = var.tag-roledescription
  }

}
