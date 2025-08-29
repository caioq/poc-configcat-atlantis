# =============================================================================
# PRODUCT MODULE
# =============================================================================
# This module contains product configuration values
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

# LOCAL VALUES
locals {
  # Product configuration - single source of truth
  product_name = "New Product Test"

  # Prod environment name
  prod_environment_name = "Production"

  # Forno environment name
  forno_environment_name = "Forno"

  # Staging environment name
  staging_environment_name = "Staging"
}

# DATA SOURCES
# Get organization ID
data "configcat_organizations" "my_organizations" {

}

# RESOURCES
# Create the product
resource "configcat_product" "my_product" {
  organization_id = data.configcat_organizations.my_organizations.organizations.0.organization_id
  name = local.product_name
  description = "New Product Test Description"
  order = 0
}

# Create default environments: production, forno, staging
resource "configcat_environment" "prod_environment" {
  product_id = configcat_product.my_product.id
  name = local.prod_environment_name
  description = "Production environment for ${local.product_name}"
  order = 0
}

resource "configcat_environment" "forno_environment" {
  product_id = configcat_product.my_product.id
  name = local.forno_environment_name
  description = "Forno environment for ${local.product_name}"
  order = 1
}

resource "configcat_environment" "staging_environment" {
  product_id = configcat_product.my_product.id
  name = local.staging_environment_name
  description = "Staging environment for ${local.product_name}"
  order = 2
}


# NEW CONFIGS ARE ADDED HERE
# Call the my-first-config module
module "my-first-config" {
  source = "./my-first-config"

  product_id = configcat_product.my_product.id
  prod_environment_id = configcat_environment.prod_environment.id
  forno_environment_id = configcat_environment.forno_environment.id
  staging_environment_id = configcat_environment.staging_environment.id

  # Pass auth variables if needed
  configcat_basic_auth_username = var.configcat_basic_auth_username
  configcat_basic_auth_password = var.configcat_basic_auth_password
}
