output "configcat_product_name" {
  value = var.configcat_product_name
}

output "beta_users_segment_id" {
  description = "The ID of the beta users segment"
  value       = configcat_segment.beta_users.id
}
