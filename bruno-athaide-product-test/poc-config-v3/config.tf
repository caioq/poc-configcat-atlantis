# Create V3 config
resource "configcat_config" "my_config" {
  product_id         = data.configcat_products.my_products.products.0.product_id
  name               = "My config v3"
  description        = "My config v3 description"
  order              = 0
  evaluation_version = "v2"
}
