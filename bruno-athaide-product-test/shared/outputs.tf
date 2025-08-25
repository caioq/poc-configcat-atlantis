output "configcat_product_name" {
  value = var.configcat_product_name
}

# output "configcat_username" {
#   value = var.configcat_username
# }

# output "configcat_password" {
#   value = var.configcat_password
#   sensitive = true
# }

output "beta_users_segment_id" {
  description = "The ID of the beta users segment"
  value       = configcat_segment.beta_users.id
}
