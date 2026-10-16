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

output "postgres_fqdn" {
  description = "FQDN del servidor PostgreSQL Flexible"
  value       = azurerm_postgresql_flexible_server.qa.fqdn
}

output "postgres_database_name" {
  description = "Nombre de la base de datos creada"
  value       = azurerm_postgresql_flexible_server_database.qa.name
}

output "postgres_admin_login" {
  description = "Usuario administrador de PostgreSQL"
  value       = azurerm_postgresql_flexible_server.qa.administrator_login
}