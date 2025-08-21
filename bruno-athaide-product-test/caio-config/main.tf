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

variable "configcat_basic_auth_username" {
  description = "ConfigCat Basic Auth Username"
  type        = string
}

variable "configcat_basic_auth_password" {
  description = "ConfigCat Basic Auth Password"
  type        = string
  sensitive   = true
}

provider "configcat" {
  # Use environment variables directly
  basic_auth_username = var.configcat_basic_auth_username != "" ? var.configcat_basic_auth_username : null
  basic_auth_password = var.configcat_basic_auth_password != "" ? var.configcat_basic_auth_password : null
}
