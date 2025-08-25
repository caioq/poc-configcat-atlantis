# =============================================================================
# PRODUCT MODULE
# =============================================================================
# This module contains product-level configuration
# =============================================================================

terraform {
  required_providers {
    configcat = {
      source  = "configcat/configcat"
      version = "~> 5.0"
    }
  }
}

# Local variable for product name - single source of truth
locals {
  product_name = "Bruno Athaide Product Test"
}
