# Create segment
resource "configcat_segment" "my_segment" {
  product_id           = module.parent_config.product_id
  name                 = "Beta users"
  description          = "Beta users' description"
  comparison_attribute = "email"
  comparator           = "sensitiveIsOneOf"
  comparison_value     = "betauser1@example.com,betauser2@example.com"
}
