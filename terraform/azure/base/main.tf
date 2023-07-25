resource "azurerm_resource_group" "rg" {
  name     = "${var.prefix}-rg"
  location = var.location

  tags = var.tags
}

module "vnet" {
  source  = "snowplow-devops/vnet/azurerm"
  version = "0.1.2"

  name                = "${var.prefix}-vnet"
  resource_group_name = azurerm_resource_group.rg.name

  tags = var.tags

  depends_on = [azurerm_resource_group.rg]
}
