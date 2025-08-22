# Create string setting
resource "configcat_setting" "my_string_setting_v2" {
  config_id    = configcat_config.my_config.id
  key          = "StringSettingKey"
  name         = "String setting"
  order        = 2
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
  ]
}

# Create boolean setting
resource "configcat_setting" "my_bool_setting_v2" {
  config_id    = configcat_config.my_config.id
  key          = "BoolSettingKey"
  name         = "Bool feature flag"
  order        = 1
  setting_type = "boolean"
}

# Create boolean setting value with advanced targeting
resource "configcat_setting_value_v2" "bool_setting_value" {
  environment_id = data.configcat_environments.prod_environment.environments.0.environment_id
  setting_id     = configcat_setting.my_bool_setting_v2.id

  mandatory_notes = "mandatory notes"

  value = { bool_value = true }

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
        {
          user_condition = {
            comparison_attribute = "color"
            comparator           = "isOneOf"
            comparison_value = {
              list_values = [
                { value = "#000000", hint = "black" },
                { value = "red" },
              ]
            }
          }
        },
        {
          segment_condition = {
            segment_id = configcat_segment.my_segment.id
            comparator = "isIn"
          }
        },
        {
          prerequisite_flag_condition = {
            prerequisite_setting_id = configcat_setting.my_string_setting_v2.id
            comparator              = "doesNotEqual"
            comparison_value        = { string_value = "test" }
          }
        }
      ]
      value = { bool_value = true }
    },

    {
      conditions = [
        {
          user_condition = {
            comparison_attribute = "county"
            comparator           = "sensitiveTextEquals"
            comparison_value     = { string_value = "Hungary" }
          }
        },
      ],

      percentage_options = [
        {
          percentage = 50
          value      = { bool_value = true }
        },
        {
          percentage = 50
          value      = { bool_value = false }
        }
      ]
    },

    {
      percentage_options = [
        {
          percentage = 30
          value      = { bool_value = true }
        },
        {
          percentage = 70
          value      = { bool_value = false }
        }
      ]
    },
  ]
}

# Create feature flag with extra metadata fields
resource "configcat_setting" "metadata_test_flag" {
  config_id    = configcat_config.my_config.id
  key          = "metadataTestFlag"
  name         = "Metadata Test Feature Flag"
  hint         = "Testing extra metadata fields like expiry_date and active status"
  order        = 3
  setting_type = "boolean"
}

# Create setting value for metadata test flag
resource "configcat_setting_value_v2" "metadata_test_flag_value" {
  environment_id = data.configcat_environments.prod_environment.environments.0.environment_id
  setting_id     = configcat_setting.metadata_test_flag.id

  value = { bool_value = true }

  # Test if we can add metadata to setting values as well
  mandatory_notes = "Testing metadata capabilities - expiry: 2024-12-31, active: true"

  targeting_rules = [
    {
      conditions = [
        {
          user_condition = {
            comparison_attribute = "email"
            comparator           = "sensitiveTextEquals"
            comparison_value     = { string_value = "@configcat.com" }
          }
        }
      ]
      value = { bool_value = false }
    }
  ]
}

# Create another setting to test different metadata approaches
resource "configcat_setting" "advanced_metadata_flag" {
  config_id    = configcat_config.my_config.id
  key          = "advancedMetadataFlag"
  name         = "Advanced Metadata Feature Flag"
  hint         = "Testing various metadata field approaches"
  order        = 4
  setting_type = "string"
}

# Create setting value with metadata in notes
resource "configcat_setting_value_v2" "advanced_metadata_flag_value" {
  environment_id = data.configcat_environments.prod_environment.environments.0.environment_id
  setting_id     = configcat_setting.advanced_metadata_flag.id

  value = { string_value = "default_value" }

  # Store metadata as structured notes to see if we can work around provider limitations
  mandatory_notes = "METADATA: {\"expiry_date\": \"2024-12-31\", \"active\": true, \"priority\": \"high\", \"owner\": \"qa-team\"}"

  targeting_rules = [
    {
      conditions = [
        {
          user_condition = {
            comparison_attribute = "email"
            comparator           = "sensitiveTextEquals"
            comparison_value     = { string_value = "@configcat.com" }
          }
        }
      ]
      value = { string_value = "internal_value" }
    }
  ]
}

# Create experimental metadata test setting
resource "configcat_setting" "experimental_metadata_flag" {
  config_id    = configcat_config.my_config.id
  key          = "experimentalMetadataFlag"
  name         = "Experimental Metadata Feature Flag"
  hint         = "Testing experimental metadata fields to discover provider capabilities"
  order        = 5
  setting_type = "string"
}

# Create setting value with experimental metadata
resource "configcat_setting_value_v2" "experimental_metadata_flag_value" {
  environment_id = data.configcat_environments.prod_environment.environments.0.environment_id
  setting_id     = configcat_setting.experimental_metadata_flag.id

  value = { string_value = "experimental_value" }

  # Test structured metadata in notes as a workaround
  mandatory_notes = "EXPERIMENTAL_METADATA: {\"expiry_date\": \"2024-12-31\", \"active\": true, \"priority\": \"high\", \"owner\": \"qa-team\", \"created_by\": \"terraform\", \"environment\": \"production\", \"version\": \"1.0.0\"}"

  targeting_rules = [
    {
      conditions = [
        {
          user_condition = {
            comparison_attribute = "email"
            comparator           = "sensitiveTextEquals"
            comparison_value     = { string_value = "@configcat.com" }
          }
        }
      ]
      value = { string_value = "experimental_internal_value" }
    }
  ]
}

# Create a setting specifically for testing expiry and active metadata
resource "configcat_setting" "expiry_active_test_flag" {
  config_id    = configcat_config.my_config.id
  key          = "expiryActiveTestFlag"
  name         = "Expiry and Active Test Feature Flag"
  hint         = "Testing expiry_date and active properties specifically"
  order        = 6
  setting_type = "boolean"

  # The hint field can store metadata-like information
  # hint = "EXPIRY: 2024-12-31, ACTIVE: true, PRIORITY: high"
}

# Create setting value with expiry and active metadata in notes
resource "configcat_setting_value_v2" "expiry_active_test_flag_value" {
  environment_id = data.configcat_environments.prod_environment.environments.0.environment_id
  setting_id     = configcat_setting.expiry_active_test_flag.id

  value = { bool_value = true }

  # Store expiry and active metadata in mandatory notes
  mandatory_notes = "EXPIRY_DATE: 2024-12-31T23:59:59Z, ACTIVE: true, PRIORITY: high, OWNER: qa-team, CREATED: 2024-01-01, EXPIRES: 2024-12-31"

  targeting_rules = [
    {
      conditions = [
        {
          user_condition = {
            comparison_attribute = "email"
            comparator           = "sensitiveTextEquals"
            comparison_value     = { string_value = "@configcat.com" }
          }
        }
      ]
      value = { bool_value = false }
    }
  ]
}
