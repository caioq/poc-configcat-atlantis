# =============================================================================
# CONFIG MODULE
# =============================================================================
# This module contains config configuration values
# =============================================================================

terraform {
  required_providers {
    configcat = {
      source  = "configcat/configcat"
      version = "~> 5.0"
    }
  }
}

# PROVIDER
provider "configcat" {
  # Use environment variables directly
  basic_auth_username = var.configcat_basic_auth_username != "" ? var.configcat_basic_auth_username : null
  basic_auth_password = var.configcat_basic_auth_password != "" ? var.configcat_basic_auth_password : null
}

# LOCAL VALUES
locals {
  config_name = "My First Config"
}

# RESOURCES
# Create the config
resource "configcat_config" "my_config" {
  product_id = var.product_id
  name = local.config_name
  description = "My First Config Description"
  order = 0
  evaluation_version = "v2"
}

# FLAGS
module "my-flags" {
  source = "./flags"

  config_id = configcat_config.my_config.id
  prod_environment_id = var.prod_environment_id
  forno_environment_id = var.forno_environment_id
  staging_environment_id = var.staging_environment_id
}
