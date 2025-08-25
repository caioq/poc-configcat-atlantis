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

# Variable for product ID - will be passed from calling modules
variable "configcat_product_id" {
  description = "ConfigCat Product ID"
  type        = string
}
