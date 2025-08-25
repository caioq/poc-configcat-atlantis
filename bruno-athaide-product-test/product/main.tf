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
# To reuse this value in other modules, reference: module.product.configcat_product_name
locals {
  product_name = "Bruno Athaide Product Test"
}
