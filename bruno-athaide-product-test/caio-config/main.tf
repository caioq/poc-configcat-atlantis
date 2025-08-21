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

variable "configcat_username" {
  description = "ConfigCat Basic Auth Username"
  type        = string
}

variable "configcat_password" {
  description = "ConfigCat Basic Auth Password"
  type        = string
  sensitive   = true
}

provider "configcat" {
  # Usando as variáveis de ambiente que você já tem configuradas
  basic_auth_username = var.configcat_username
  basic_auth_password = var.configcat_password
}
