output "application_name" {
  value = random_string.suffix.result
}

output "unique_name" {
  value = random_string.suffix.result
}


output "monitoreo_habilitado" {
  description = "Muestra si el monitoreo está activo"
  value       = var.enable_monitoring
}

output "lista_regiones" {
  description = "Muestra todas las regiones configuradas"
  value       = var.regions
}

output "etiquetas_entorno" {
  description = "Muestra el mapa completo de etiquetas"
  value       = var.environment_tags
}

output "redes_permitidas" {
  description = "Muestra el conjunto de redes permitidas"
  value       = var.allowed_networks
}