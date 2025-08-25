# =============================================================================
# FORNO ENVIRONMENT MODULE
# =============================================================================
# This is a child module, not a standalone Terraform workspace
# It references the parent configuration and provides forno-specific resources
# =============================================================================

# Reference the parent directory configuration
module "parent_config" {
  source = "./.."
}

# Get forno environment from parent
data "configcat_environments" "forno_environment" {
  product_id = module.parent_config.product_id
  name_filter_regex = "Forno"
}
