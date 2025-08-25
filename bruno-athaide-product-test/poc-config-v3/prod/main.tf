# =============================================================================
# PRODUCTION ENVIRONMENT MODULE
# =============================================================================
# This is a child module, not a standalone Terraform workspace
# It references the parent configuration and provides prod-specific resources
# =============================================================================

# Reference the parent directory configuration
module "parent_config" {
  source = "./.."
}

# Reference the segments module
module "segments" {
  source = "../../segments"
}

# Get production environment from parent
data "configcat_environments" "prod_environment" {
  product_id = module.parent_config.product_id
  name_filter_regex = "Production"
}
