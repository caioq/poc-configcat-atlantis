# =============================================================================
# SHARED MODULE
# =============================================================================
# This module contains shared configuration values
# =============================================================================

terraform {
  required_providers {
    configcat = {
      source  = "configcat/configcat"
      version = "~> 5.0"
    }
  }
}

# Local values for shared configuration
locals {
  # Product configuration - single source of truth
  product_name = "Bruno Athaide Product Test"

  # Prod environment name
  prod_environment_name = "Production"

  # Forno environment name
  forno_environment_name = "Forno"

  # Staging environment name
  staging_environment_name = "Staging"
}
