# =============================================================================
# SHARED MODULE - NOT A STANDALONE TERRAFORM WORKSPACE
# =============================================================================
# This directory contains a Terraform module that should be called by other
# modules. Do not run terraform commands directly in this directory.
# =============================================================================

terraform {
  required_providers {
    configcat = {
      source  = "configcat/configcat"
      version = "~> 5.0"
    }
  }
}
