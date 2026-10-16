variable "subscription_id" {
  description = "ID de la suscripción de Azure for Students"
  type        = string
  sensitive   = true
}

variable "location" {
  description = "Región de Azure"
  type        = string
  default     = "mexicocentral"
}

variable "suffix" {
  description = "Sufijo único para los nombres de recursos"
  type        = string
  default     = "utvt-integradora-qa-mxc-001"
}

variable "service_plan_sku_name" {
  description = "SKU del App Service Plan"
  type        = string
  default     = "F1"
}

variable "application_type" {
  description = "Tipo de Application Insights"
  type        = string
  default     = "web"
}

variable "node_version" {
  description = "Versión de Node.js"
  type        = string
  default     = "24-lts"
}

variable "log_analytics_sku" {
  description = "SKU del Log Analytics Workspace"
  type        = string
  default     = "PerGB2018"
}

variable "web_app_name" {
  description = "Nombre de la aplicación web"
  type        = string
  default     = "app-utvt-integradora-web-qa-mxc-003"
}

variable "pg_admin_login" {
  description = "Usuario administrador de PostgreSQL"
  type        = string
  default     = "pgadmin"
}

variable "pg_admin_password" {
  description = "Contraseña del administrador de PostgreSQL"
  type        = string
  sensitive   = true
}

variable "pg_database_name" {
  description = "Nombre de la base de datos inicial"
  type        = string
  default     = "integradora"
}

variable "pg_sku_name" {
  description = "SKU de PostgreSQL Flexible Server (B1MS entra en cuota gratuita de estudiante)"
  type        = string
  default     = "B_Standard_B1ms"
}

variable "pg_storage_mb" {
  description = "Almacenamiento en MB (32768 = 32 GB, dentro de la cuota gratuita)"
  type        = number
  default     = 32768
}

variable "pg_version" {
  description = "Versión de PostgreSQL"
  type        = string
  default     = "16"
}

variable "pg_public_access" {
  description = "true = acceso público con firewall; false = Private Endpoint (requiere VNet Integration en App Service de pago)"
  type        = bool
  default     = true
}