# Infrastructure Creation File
# Use this file ONLY when you need to create new infrastructure
# After creation, rename this file to create-infrastructure.tf.disabled

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
