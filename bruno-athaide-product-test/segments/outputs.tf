# =============================================================================
# SEGMENTS OUTPUTS
# =============================================================================

output "beta_users_segment_id" {
  description = "The ID of the beta users segment"
  value       = configcat_segment.beta_users.id
}

# Add more segment outputs here as needed
# output "premium_users_segment_id" {
#   description = "The ID of the premium users segment"
#   value       = configcat_segment.premium_users.id
# }
