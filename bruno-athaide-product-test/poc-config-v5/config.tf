# Create Config v5
resource "configcat_config" "my_config" {
  product_id         = data.configcat_products.my_products.products.0.product_id
  name               = local.config_name
  description        = "POC Config v5 Description"
  order              = 0
  evaluation_version = "v2"
}
