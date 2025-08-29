# =============================================================================
# PRODUCT MODULE OUTPUTS
# =============================================================================

output "product_name" {
  description = "The product name from product configuration"
  value       = local.product_name
}

output "prod_environment_name" {
  description = "The production environment name from product configuration"
  value       = local.prod_environment_name
}

output "forno_environment_name" {
  description = "The forno environment name from product configuration"
  value       = local.forno_environment_name
}

output "staging_environment_name" {
  description = "The staging environment name from product configuration"
  value       = local.staging_environment_name
}
