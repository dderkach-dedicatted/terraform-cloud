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
    image                 = string
    startup_cmd           = string
    memory                = number
    memoryreservation     = number
    task_port             = number
    container_init_process = string
    desired_count         = number
    enable_lb             = bool
  }))
  default = {
    "first-dderkach" = {
      rg_name = "first-dderkach-${terraform.workspace}"
      location = "South Central US"
    },
    "second_dderkach" = {
      rg_name = "second-dderkach-${terraform.workspace}"
      location = "East US"
    }
  }
}

resource "azurerm_resource_group" "main" {
  for_each = var.groups
  name     =  each.value["rg_name"]
  location =  each.value["location"]
}
