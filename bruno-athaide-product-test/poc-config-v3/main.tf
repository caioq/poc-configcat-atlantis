terraform {
  required_providers {
    configcat = {
      source  = "configcat/configcat"
      version = "~> 5.0"
    }
  }
}

# Get product ID first
data "configcat_products" "my_products" {
  name_filter_regex = module.product.configcat_product_name
}

# Reference the product module
module "product" {
  source = "../product"
  configcat_product_id = data.configcat_products.my_products.products.0.product_id
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

# Get production environment
data "configcat_environments" "prod_environment" {
  product_id = data.configcat_products.my_products.products.0.product_id
  name_filter_regex = "Production"
}

# Outputs for child modules
output "config_id" {
  description = "The config ID from the config resource"
  value       = configcat_config.my_config.id
}

output "product_id" {
  description = "The product ID from the products data source"
  value       = data.configcat_products.my_products.products.0.product_id
}

output "product" {
  description = "The product module outputs"
  value       = module.product
}
