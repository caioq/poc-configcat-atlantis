# =============================================================================
# CONFIG MODULE
# =============================================================================
# This module contains config configuration values
# =============================================================================

terraform {
  required_providers {
    configcat = {
      source  = "configcat/configcat"
      version = "~> 5.0"
    }
  }
}

# INPUT VARIABLES
variable "product_id" {
  description = "The ConfigCat product ID from the parent configuration"
  type        = string
}

variable "prod_environment_id" {
  description = "The ConfigCat production environment ID from the parent configuration"
  type        = string
}

variable "forno_environment_id" {
  description = "The ConfigCat forno environment ID from the parent configuration"
  type        = string
}

variable "staging_environment_id" {
  description = "The ConfigCat staging environment ID from the parent configuration"
  type        = string
}

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

# PROVIDER
provider "configcat" {
  # Use environment variables directly
  basic_auth_username = var.configcat_basic_auth_username != "" ? var.configcat_basic_auth_username : null
  basic_auth_password = var.configcat_basic_auth_password != "" ? var.configcat_basic_auth_password : null
}

# LOCAL VALUES
locals {
  config_name = "My First Config"
}

# RESOURCES
# Create the config
resource "configcat_config" "my_config" {
  product_id = var.product_id
  name = local.config_name
  description = "My First Config Description"
  order = 0
  evaluation_version = "v2"
}

# NEW FLAGS ARE ADDED HERE
