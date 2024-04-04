terraform {
  required_version = ">= 1.6"

  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "=3.79.0"
    }
  }
}

provider "azurerm" {
  features {}
}

variable "groups" {
  type    = map(string)
  default = {
    "first-dderkach"  = "South Central US"
    "second-dderkach" = "West Europe"
    "third-dderkach"  = "West Europe"
  }
}

resource "azurerm_resource_group" "main" {
  for_each = var.groups
  name     = "${each.key}-${terraform.workspace}"
  location = each.value
}
