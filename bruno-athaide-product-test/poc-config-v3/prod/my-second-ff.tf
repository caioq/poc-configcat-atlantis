# Create a simple boolean feature flag
resource "configcat_setting" "my_second_ff" {
  config_id    = data.configcat_configs.my_configs.configs.0.config_id
  key          = "MySecondFF"
  name         = "My Second Feature Flag"
  order        = 1
  setting_type = "boolean"
}

# Create the feature flag value
resource "configcat_setting_value_v2" "my_second_ff_value" {
  environment_id = data.configcat_environments.prod_environment.environments.0.environment_id
  setting_id     = configcat_setting.my_second_ff.id

  value = { bool_value = false }

}
