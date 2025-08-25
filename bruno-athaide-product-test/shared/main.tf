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

  # Add other shared values here as needed
  # environment = "production"
  # region = "us-east-1"
}
