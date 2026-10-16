resource "azurerm_postgresql_flexible_server" "qa" {
  name                   = "psql-${var.suffix}"
  resource_group_name    = azurerm_resource_group.qa.name
  location               = azurerm_resource_group.qa.location
  version                = var.pg_version
  administrator_login    = var.pg_admin_login
  administrator_password = var.pg_admin_password

  sku_name   = var.pg_sku_name
  storage_mb = var.pg_storage_mb

  # Si usas Private Endpoint, descomenta las siguientes dos líneas.
  # Si usas acceso público, déjalas comentadas y usa la regla de firewall de abajo.
  # delegated_subnet_id = azurerm_subnet.private_endpoint.id
  # private_dns_zone_id = azurerm_private_dns_zone.postgres.id

  # Si NO usas Private Endpoint, debes habilitar acceso público:
  public_network_access_enabled = var.pg_public_access

  tags = local.tags

  lifecycle {
    ignore_changes = [
      zone,
      high_availability,
    ]
  }
}

# Base de datos inicial
resource "azurerm_postgresql_flexible_server_database" "qa" {
  name      = var.pg_database_name
  server_id = azurerm_postgresql_flexible_server.qa.id
  charset   = "UTF8"
  collation = "en_US.utf8"
}

# Regla de firewall para permitir App Service (solo si usas acceso público)
resource "azurerm_postgresql_flexible_server_firewall_rule" "allow_azure" {
  count            = var.pg_public_access ? 1 : 0
  name             = "allow-azure-services"
  server_id        = azurerm_postgresql_flexible_server.qa.id
  start_ip_address = "0.0.0.0"
  end_ip_address   = "0.0.0.0"
}

# Private Endpoint para PostgreSQL (solo si NO usas acceso público)
resource "azurerm_private_endpoint" "postgres" {
  count               = var.pg_public_access ? 0 : 1
  name                = "pe-psql-${var.suffix}"
  location            = azurerm_resource_group.qa.location
  resource_group_name = azurerm_resource_group.qa.name
  subnet_id           = azurerm_subnet.private_endpoint.id

  private_service_connection {
    name                           = "psql-connection"
    private_connection_resource_id = azurerm_postgresql_flexible_server.qa.id
    subresource_names              = ["postgresqlServer"]
    is_manual_connection           = false
  }

  private_dns_zone_group {
    name                 = "postgres-dns-group"
    private_dns_zone_ids = [azurerm_private_dns_zone.postgres.id]
  }

  tags = local.tags
}