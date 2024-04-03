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
  type = map(object({
    rg_name = string
    location = string
  }))
  default = {
    "first-dderkach" = {
      rg_name = "first-dderkach"
      location = "South Central US"
    },
    "second_dderkach" = {
      rg_name = "second-dderkach"
      location = "East US"
    }
  }
}

resource "azurerm_resource_group" "main" {
  for_each = var.groups
  name     =  "each.value["rg_name"]-${terraform.workspace}"
  location =  each.value["location"]
}
