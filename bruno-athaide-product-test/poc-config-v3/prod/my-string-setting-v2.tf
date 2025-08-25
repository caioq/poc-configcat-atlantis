# Create string setting
resource "configcat_setting" "my_string_setting_v2" {
  config_id    = module.parent_config.config_id
  key          = "StringSettingKey"
  name         = "String setting"
  order        = 0
  setting_type = "string"
}

# Create string setting value with V2 targeting rules
resource "configcat_setting_value_v2" "string_setting_value" {
  environment_id = data.configcat_environments.prod_environment.environments.0.environment_id
  setting_id     = configcat_setting.my_string_setting_v2.id

  value = { string_value = "test" }

  targeting_rules = [
    {
      conditions = [
        {
          user_condition = {
            comparison_attribute = "email"
            comparator           = "sensitiveTextEquals"
            comparison_value     = { string_value = "@configcat.com" }
          }
        },
      ]
      value = { string_value = "custom" }
    },
    {
      conditions = [
        {
          segment_condition = {
            segment_id = module.segments.beta_users_segment_id
            comparator = "isIn"
          }
        },
      ]
      value = { string_value = "beta-feature" }
    },
  ]
}
