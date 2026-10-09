output "resource_group_name" {
  description = "Nombre del grupo de recursos"
  value       = azurerm_resource_group.qa.name
}

output "web_app_url" {
  description = "URL de la aplicación web QA"
  value       = "https://${azurerm_linux_web_app.qa.default_hostname}"
}

output "application_insights_name" {
  description = "Nombre de Application Insights"
  value       = azurerm_application_insights.qa.name
}