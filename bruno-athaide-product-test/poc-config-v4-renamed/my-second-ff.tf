# Create a simple boolean feature flag
resource "configcat_setting" "my_second_ff" {
  config_id    = configcat_config.my_config.id
  key          = "MySecondFF"
  name         = "My Second Feature Flag"
  order        = 1
  setting_type = "string"
}

# PROD
resource "configcat_setting_value_v2" "my_second_ff_prod" {
  environment_id = data.configcat_environments.prod_environment.environments.0.environment_id
  setting_id     = configcat_setting.my_second_ff.id

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
            segment_id = data.configcat_segments.beta_users_segment.segments.0.segment_id
            comparator = "isIn"
          }
        },
      ]
      value = { string_value = "beta-feature" }
    },
  ]
}

# FORNO
resource "configcat_setting_value_v2" "my_second_ff_forno" {
  environment_id = data.configcat_environments.forno_environment.environments.0.environment_id
  setting_id     = configcat_setting.my_second_ff.id

  value = { string_value = "test" }

}

# STAGING
resource "configcat_setting_value_v2" "my_second_ff_staging" {
  environment_id = data.configcat_environments.staging_environment.environments.0.environment_id
  setting_id     = configcat_setting.my_second_ff.id

  value = { string_value = "test" }

}
