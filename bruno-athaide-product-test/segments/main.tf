# =============================================================================
# SEGMENTS WORKSPACE
# =============================================================================
# This directory is a standalone Terraform workspace for managing segments
# =============================================================================

terraform {
  required_providers {
    configcat = {
      source  = "configcat/configcat"
      version = "~> 5.0"
    }
  }
}

# Reference the shared module to get the product name
module "shared" {
  source = "../shared"
}

# Get product ID using the product name from shared configuration
data "configcat_products" "my_products" {
  name_filter_regex = module.shared.product_name
}

# Variables for authentication
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
  basic_auth_username = var.configcat_basic_auth_username != "" ? var.configcat_basic_auth_username : null
  basic_auth_password = var.configcat_basic_auth_password != "" ? var.configcat_basic_auth_password : null
}
