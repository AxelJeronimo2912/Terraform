locals {
  location = "mexicocentral"
  suffix   = "utvt-integradora-qa-mxc-001"

  tags = {
    environment = "qa"
    project     = "integradora"
    managed_by  = "terraform"
    owner       = "Axel Joaquin Cruz Jeronimo"
  }
}