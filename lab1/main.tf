terraform {
  required_providers {
    random = {
      source  = "hashicorp/random"
      version = "~> 3.0"
    }
  }

  required_version = ">= 1.0.0"
}

resource "random_string" "suffix" {
  length  = var.length
  special = true
}

locals {
  # Genera un nombre único para el recurso utilizando un prefijo y un sufijo aleatorio.
  unique_name = "${var.application_name}-${var.environment}-${random_string.suffix.result}"
}