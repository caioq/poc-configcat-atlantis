# =============================================================================
# SEGMENTS
# =============================================================================

# Beta users segment
resource "configcat_segment" "beta_users" {
  product_id           = var.configcat_product_id
  name                 = "Beta users"
  description          = "Beta users' description"
  comparison_attribute = "email"
  comparator           = "sensitiveIsOneOf"
  comparison_value     = "betauser1@example.com,betauser2@example.com"
}

# Add more segments here as needed
# resource "configcat_segment" "premium_users" {
#   product_id           = var.configcat_product_id
#   name                 = "Premium users"
#   description          = "Premium users segment"
#   comparison_attribute = "subscription_tier"
#   comparator           = "sensitiveTextEquals"
#   comparison_value     = "premium"
# }
