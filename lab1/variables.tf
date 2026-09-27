variable "length" {
  description = "Length of the random string"
  type        = number
}

variable "application_name" {
  description = "Nombre de la aplicación"
  type        = string
  default     = "integradora"
}

variable "environment" {
  description = "Entorno de despliegue (dev, staging, prod)"
  type        = string
  default     = "dev"
}