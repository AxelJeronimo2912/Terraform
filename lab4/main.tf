resource "azurerm_resource_group" "qa" {
  name     = "rg-${var.suffix}"
  location = var.location
  tags     = local.tags
}