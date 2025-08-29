# Create a simple boolean feature flag
resource "configcat_setting" "my_team_flag" {
  config_id    = var.config_id
  key          = "MyTeamFlag"
  name         = "My Team Flag"
  order        = 0
  setting_type = "boolean"
}

# PROD
resource "configcat_setting_value_v2" "my_team_flag_value_prod" {
  environment_id = data.configcat_environments.prod_environment.environments.0.environment_id
  setting_id     = configcat_setting.my_team_flag.id

  value = { bool_value = false }

  mandatory_notes = "{\"expiry_date\": \"2024-12-31\", \"active\": true, \"priority\": \"high\", \"owner\": \"qa-team\"}"
}

# FORNO
resource "configcat_setting_value_v2" "my_team_flag_value_forno" {
  environment_id = data.configcat_environments.forno_environment.environments.0.environment_id
  setting_id     = configcat_setting.my_team_flag.id

  value = { bool_value = false }

  mandatory_notes = "{\"expiry_date\": \"2024-12-31\", \"active\": true, \"priority\": \"high\", \"owner\": \"qa-team\"}"
}

# STAGING
resource "configcat_setting_value_v2" "my_team_flag_value_staging" {
  environment_id = data.configcat_environments.staging_environment.environments.0.environment_id
  setting_id     = configcat_setting.my_team_flag.id

  value = { bool_value = false }
}
