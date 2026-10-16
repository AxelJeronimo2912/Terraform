resource "azurerm_service_plan" "qa" {
  name                = "asp-${var.suffix}"
  location            = azurerm_resource_group.qa.location
  resource_group_name = azurerm_resource_group.qa.name
  os_type             = "Linux"
  sku_name            = var.service_plan_sku_name
  tags                = local.tags
}

resource "azurerm_linux_web_app" "qa" {
  name                = var.web_app_name
  location            = azurerm_resource_group.qa.location
  resource_group_name = azurerm_resource_group.qa.name
  service_plan_id     = azurerm_service_plan.qa.id
  https_only          = true

  site_config {
    always_on           = false
    minimum_tls_version = "1.2"
    ftps_state          = "Disabled"

    application_stack {
      node_version = var.node_version
    }
  }

  app_settings = {
    APPLICATIONINSIGHTS_CONNECTION_STRING      = azurerm_application_insights.qa.connection_string
    ApplicationInsightsAgent_EXTENSION_VERSION = "~3"
    DATABASE_URL = "postgresql://${var.pg_admin_login}:${var.pg_admin_password}@${azurerm_postgresql_flexible_server.qa.fqdn}:5432/${var.pg_database_name}?sslmode=require"
    DB_HOST     = azurerm_postgresql_flexible_server.qa.fqdn
    DB_NAME     = var.pg_database_name
    DB_USER     = var.pg_admin_login
    DB_PASSWORD = var.pg_admin_password
  }

  tags = local.tags
}