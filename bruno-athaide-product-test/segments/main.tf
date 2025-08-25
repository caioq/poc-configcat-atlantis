# =============================================================================
# SEGMENTS MODULE
# =============================================================================
# This directory contains shared segments that can be used across the product
# =============================================================================

terraform {
  required_providers {
    configcat = {
      source  = "configcat/configcat"
      version = "~> 5.0"
    }
  }
}

# Reference the product module to get the product_id
module "product" {
  source = "../product"
}
