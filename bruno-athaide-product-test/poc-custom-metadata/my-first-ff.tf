# Create a simple boolean feature flag
resource "configcat_setting" "my_first_ff" {
  config_id    = configcat_config.my_config.id
  key          = "MyFirstFF"
  name         = "My First Feature Flag"
  order        = 0
  setting_type = "boolean"
}

# PROD
resource "configcat_setting_value_v2" "my_first_ff_value_prod" {
  environment_id = data.configcat_environments.prod_environment.environments.0.environment_id
  setting_id     = configcat_setting.my_first_ff.id

  value = { bool_value = false }

  mandatory_notes = "{\"expiry_date\": \"2024-12-31\", \"active\": true, \"priority\": \"high\", \"owner\": \"qa-team\"}"
}

# FORNO
resource "configcat_setting_value_v2" "my_first_ff_value_forno" {
  environment_id = data.configcat_environments.forno_environment.environments.0.environment_id
  setting_id     = configcat_setting.my_first_ff.id

  value = { bool_value = false }

  mandatory_notes = "{\"expiry_date\": \"2024-12-31\", \"active\": true, \"priority\": \"high\", \"owner\": \"qa-team\"}"
}

# STAGING
resource "configcat_setting_value_v2" "my_first_ff_value_staging" {
  environment_id = data.configcat_environments.staging_environment.environments.0.environment_id
  setting_id     = configcat_setting.my_first_ff.id

  value = { bool_value = false }

}
