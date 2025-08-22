
data "configcat_products" "my_products" {
  # name_filter_regex = var.configcat_product_name
  name_filter_regex = module.shared.configcat_product_name
}

output "product_id" {
  value = data.configcat_products.my_products.products.0.product_id
}

data "configcat_environments" "prod_environment" {
  product_id = data.configcat_products.my_products.products.0.product_id
  name_filter_regex = "Production"
}

output "prod_environment_id" {
  value = data.configcat_environments.prod_environment.environments.0.environment_id
}
