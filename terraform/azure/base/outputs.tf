output "resource_group_name" {
  description = "The name of the resource group"
  value       = azurerm_resource_group.rg.name
}

output "resource_group_location" {
  description = "The location of the resource group"
  value       = azurerm_resource_group.rg.location
}

output "vnet_id" {
  description = "The ID of the vNet"
  value       = module.vnet.vnet_id
}

output "vnet_name" {
  description = "The name of the vNet"
  value       = module.vnet.vnet_name
}

output "vnet_subnets" {
  description = "The IDs of subnets created inside the vNet"
  value       = module.vnet.vnet_subnets
}

output "vnet_subnets_name_id" {
  description = "Can be queried subnet ID by subnet name by using lookup(module.vnet.vnet_subnets_name_id, subnet1)"
  value       = module.vnet.vnet_subnets_name_id
}
