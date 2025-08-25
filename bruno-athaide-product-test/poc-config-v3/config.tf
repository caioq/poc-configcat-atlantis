# Create V3 config
resource "configcat_config" "my_config" {
  product_id         = data.configcat_products.my_products.products.0.product_id
  name               = "POC Config V3"
  description        = "POC Config V3 description - testing"
  order              = 0
  evaluation_version = "v2"
}
