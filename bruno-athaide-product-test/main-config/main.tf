terraform {
  required_version = ">= 1.0"

  required_providers {
    configcat = {
      source  = "configcat/configcat"
      version = "~> 5.0"
    }
  }
}

# Reference the shared module
module "shared" {
  source = "../shared"
}

provider "configcat" {
  # Usando as variáveis de ambiente que você já tem configuradas
  basic_auth_username = var.configcat_basic_auth_username != "" ? var.configcat_basic_auth_username : null
  basic_auth_password = var.configcat_basic_auth_password != "" ? var.configcat_basic_auth_password : null
}
