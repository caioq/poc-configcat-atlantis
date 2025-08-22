data "configcat_organizations" "my_organizations" {

}

data "configcat_products" "my_products" {
  # name_filter_regex = var.configcat_product_name
  name_filter_regex = module.shared.configcat_product_name
}

data "configcat_configs" "my_configs" {
  product_id = data.configcat_products.my_products.products.0.product_id
  name_filter_regex = var.configcat_config_name
}

data "configcat_environments" "my_environments" {
  product_id = data.configcat_products.my_products.products.0.product_id
  name_filter_regex = "Production"
}

// Create a Feature Flag/Setting is_amazing
resource "configcat_setting" "is_amazing" {
  config_id = data.configcat_configs.my_configs.configs.0.config_id
  key = "isMyAmazingFeatureEnabled"
  name = "My amazing feature flag"
  hint = "this is the hint for my amazing feature flag"
  setting_type = "boolean"
  order = 1
}

// Initialize the Feature Flag/Setting's value is_amazing
resource "configcat_setting_value" "setting_value" {
    environment_id = data.configcat_environments.my_environments.environments.0.environment_id
    setting_id = configcat_setting.is_amazing.id
    value = "false"
}
