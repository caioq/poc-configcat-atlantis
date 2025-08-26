# =============================================================================
# SHARED MODULE
# =============================================================================
# This module contains shared configuration values
# =============================================================================

# terraform {
#   required_providers {
#     configcat = {
#       source  = "configcat/configcat"
#       version = "~> 5.0"
#     }
#   }
# }

# Local values for shared configuration
locals {
  config_name = "POC Config V4 - Renamed"
}

output "config_name" {
  description = "The config name from shared configuration"
  value       = local.config_name
}
