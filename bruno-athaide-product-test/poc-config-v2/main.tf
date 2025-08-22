terraform {
  required_providers {
    configcat = {
      source  = "configcat/configcat"
      version = "~> 5.0"
    }
  }
}

# Reference the shared module with product value
module "shared" {
  source = "../shared"
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

provider "configcat" {
  # Use environment variables directly
  basic_auth_username = var.configcat_basic_auth_username != "" ? var.configcat_basic_auth_username : null
  basic_auth_password = var.configcat_basic_auth_password != "" ? var.configcat_basic_auth_password : null
}

# Get product ID from shared module
data "configcat_products" "my_products" {
  name_filter_regex = module.shared.configcat_product_name
}

# Get production environment
data "configcat_environments" "prod_environment" {
  product_id = data.configcat_products.my_products.products.0.product_id
  name_filter_regex = "Production"
}

# Create V2 config
resource "configcat_config" "my_config" {
  product_id         = data.configcat_products.my_products.products.0.product_id
  name               = "My config v2"
  description        = "My config description"
  order              = 0
  evaluation_version = "v2"
}

# Create segment
resource "configcat_segment" "my_segment" {
  product_id           = data.configcat_products.my_products.products.0.product_id
  name                 = "Beta users"
  description          = "Beta users' description"
  comparison_attribute = "email"
  comparator           = "sensitiveIsOneOf"
  comparison_value     = "betauser1@example.com,betauser2@example.com"
}
