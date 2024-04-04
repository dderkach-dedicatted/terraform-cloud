terraform {
  required_version = ">= 1.7"

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
      rg_name = "first-dderkach-env-rg"
      location = "South Central US"
    },
    "second_dderkach" = {
      rg_name = "second-dderkach-env-rg"
      location = "East US"
    }
  }
}

module "env_rg" {
  source = "../../modules/resource_group"
  groups = var.groups

}
