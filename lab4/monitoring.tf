resource "azurerm_log_analytics_workspace" "qa" {
  name                = "log-${var.suffix}"
  location            = azurerm_resource_group.qa.location
  resource_group_name = azurerm_resource_group.qa.name
  sku                 = var.log_analytics_sku
  retention_in_days   = 30
  daily_quota_gb      = 0.1
  tags                = local.tags
}

resource "azurerm_application_insights" "qa" {
  name                 = "appi-${var.suffix}"
  location             = azurerm_resource_group.qa.location
  resource_group_name  = azurerm_resource_group.qa.name
  workspace_id         = azurerm_log_analytics_workspace.qa.id
  application_type     = var.application_type
  daily_data_cap_in_gb = 0.1
  tags                 = local.tags
}