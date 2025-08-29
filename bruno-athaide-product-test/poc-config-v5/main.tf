terraform {
  required_providers {
    configcat = {
      source  = "configcat/configcat"
      version = "~> 5.0"
    }
  }
}


# Local values for config v5
locals {
  config_name = "POC Config v5"
}

# Reference the shared module to get the product name
module "shared" {
  source = "../shared"
}

# AUTHENTICATION
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
  # Use environment variables directly
  basic_auth_username = var.configcat_basic_auth_username != "" ? var.configcat_basic_auth_username : null
  basic_auth_password = var.configcat_basic_auth_password != "" ? var.configcat_basic_auth_password : null
}

# DATA SOURCES
# Get product ID first
data "configcat_products" "my_products" {
  name_filter_regex = module.shared.product_name
}

# Get production environment
data "configcat_environments" "prod_environment" {
  product_id = data.configcat_products.my_products.products.0.product_id
  name_filter_regex = module.shared.prod_environment_name
}

# Get forno environment
data "configcat_environments" "forno_environment" {
  product_id = data.configcat_products.my_products.products.0.product_id
  name_filter_regex = module.shared.forno_environment_name
}

# Get staging environment
data "configcat_environments" "staging_environment" {
  product_id = data.configcat_products.my_products.products.0.product_id
  name_filter_regex = module.shared.staging_environment_name
}

# Get beta users segment
data "configcat_segments" "beta_users_segment" {
  product_id = data.configcat_products.my_products.products.0.product_id
  name_filter_regex = "Beta users"
}

# Call the flags module
module "flags" {
  source = "./flags"

  config_id = configcat_config.my_config.id

  # Pass auth variables if needed
  configcat_basic_auth_username = var.configcat_basic_auth_username
  configcat_basic_auth_password = var.configcat_basic_auth_password
}

module "flags_team_a" {
  source = "./flags/team-a"

  config_id = configcat_config.my_config.id

  # Pass auth variables if needed
  configcat_basic_auth_username = var.configcat_basic_auth_username
  configcat_basic_auth_password = var.configcat_basic_auth_password
}
