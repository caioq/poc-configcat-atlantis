# =============================================================================
# SEGMENTS WORKSPACE
# =============================================================================
# This directory is a standalone Terraform workspace for managing segments
# =============================================================================

terraform {
  required_providers {
    configcat = {
      source  = "configcat/configcat"
      version = "~> 5.0"
    }
  }
}

# Reference the product module to get the product name
# This makes the product name truly reusable across all modules
module "product" {
  source = "../product"
  # We need to provide a dummy product_id since it's required
  # This will be overridden when segments is called as a module
  configcat_product_id = "dummy-id"
}

# Get product ID using the product name from the product module
data "configcat_products" "my_products" {
  name_filter_regex = module.product.configcat_product_name
}

# Variables for authentication
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
  basic_auth_username = var.configcat_basic_auth_username != "" ? var.configcat_basic_auth_username : null
  basic_auth_password = var.configcat_basic_auth_password != "" ? var.configcat_basic_auth_password : null
}
