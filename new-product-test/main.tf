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

# AUTHENTICATION
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

# Get organization ID
data "configcat_organizations" "my_organizations" {

}

# Create the product
resource "configcat_product" "my_product" {
  organization_id = data.configcat_organizations.my_organizations.organizations.0.organization_id
  name = local.product_name
  description = "New Product Test Description"
  order = 0
}
