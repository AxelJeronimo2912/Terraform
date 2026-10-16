# VNet principal del entorno QA
resource "azurerm_virtual_network" "qa" {
  name                = "vnet-${var.suffix}"
  location            = azurerm_resource_group.qa.location
  resource_group_name = azurerm_resource_group.qa.name
  address_space       = ["10.0.0.0/16"]
  tags                = local.tags
}

# Subred para Private Endpoint de PostgreSQL
resource "azurerm_subnet" "private_endpoint" {
  name                 = "snet-private-endpoint"
  resource_group_name  = azurerm_resource_group.qa.name
  virtual_network_name = azurerm_virtual_network.qa.name
  address_prefixes     = ["10.0.1.0/24"]

  private_endpoint_network_policies = "Disabled"
}

# Subred para Azure Bastion (opcional, para acceso a VMs)
resource "azurerm_subnet" "bastion" {
  name                 = "AzureBastionSubnet"
  resource_group_name  = azurerm_resource_group.qa.name
  virtual_network_name = azurerm_virtual_network.qa.name
  address_prefixes     = ["10.0.2.0/24"]
}

# Private DNS Zone para PostgreSQL
resource "azurerm_private_dns_zone" "postgres" {
  name                = "privatelink.postgres.database.azure.com"
  resource_group_name = azurerm_resource_group.qa.name
  tags                = local.tags
}

resource "azurerm_private_dns_zone_virtual_network_link" "postgres" {
  name                  = "postgres-dns-link"
  resource_group_name   = azurerm_resource_group.qa.name
  private_dns_zone_name = azurerm_private_dns_zone.postgres.name
  virtual_network_id    = azurerm_virtual_network.qa.id
  registration_enabled  = false
  tags                  = local.tags
}