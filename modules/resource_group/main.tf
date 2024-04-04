resource "azurerm_resource_group" "main" {
  for_each = var.groups
  name     = "${each.value["rg_name"]}-${terraform.workspace}"
  location = each.value["location"]
}

variable "groups" {
  type = map(object({
    rg_name = string
    location = string
  }))
  default = {}
}

output "instance_ids" {
  value = tomap({
    for key, value in azurerm_resource_group.main : key => value.id
  })
}