terraform {
  required_providers {
    configcat = {
      source  = "configcat/configcat"
      version = "~> 5.0"
    }
  }
}


# Product -> Config -> Setting


# Reference the parent directory configuration
# module "parent_config" {
#   source = "./.."
# }

module "shared_product" {
  source = "../../shared"
}

module "shared_config" {
  source = "../shared"
}

data "configcat_products" "my_products" {
  name_filter_regex = module.shared_product.product_name
}

# TODO: Try to use the config name as a variable
data "configcat_configs" "my_configs" {
  product_id = data.configcat_products.my_products.products.0.product_id
  name_filter_regex = module.shared_config.config_name
}


# Get production environment from parent
data "configcat_environments" "forno_environment" {
  product_id = data.configcat_products.my_products.products.0.product_id
  name_filter_regex = "Forno"
}

variable "configcat_basic_auth_username" {
  description = "ConfigCat Basic Auth Username"
  type        = string
  default     = ""
  sensitive   = true
}

variable "configcat_basic_auth_password" {
  description = "ConfigCat Basic Auth Password"
  type        = string
  default     = ""
  sensitive   = true
}

provider "configcat" {
  # Use environment variables directly
  basic_auth_username = var.configcat_basic_auth_username != "" ? var.configcat_basic_auth_username : null
  basic_auth_password = var.configcat_basic_auth_password != "" ? var.configcat_basic_auth_password : null
}
