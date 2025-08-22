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

// Create a Feature Flag/Setting is_awesome
resource "configcat_setting" "is_awesome" {
  config_id = data.configcat_configs.my_configs.configs.0.config_id
  key = "isMyAwesomeFeatureEnabled"
  name = "My awesome feature flag"
  hint = "this is the hint for my awesome feature flag"
  setting_type = "boolean"
  order = 1
}

// Initialize the Feature Flag/Setting's value is_awesome
resource "configcat_setting_value" "setting_value" {
    environment_id = data.configcat_environments.my_environments.environments.0.environment_id
    setting_id = configcat_setting.is_awesome.id
    value = "false"
}

// String type feature flag - User welcome message
resource "configcat_setting" "welcome_message" {
  config_id = data.configcat_configs.my_configs.configs.0.config_id
  key = "userWelcomeMessage"
  name = "User Welcome Message"
  hint = "Customizable welcome message for users"
  setting_type = "string"
  order = 2
}

resource "configcat_setting_value" "welcome_message_value" {
  environment_id = data.configcat_environments.my_environments.environments.0.environment_id
  setting_id = configcat_setting.welcome_message.id
  value = "Welcome to our amazing platform!"
}

// Double type feature flag - Price multiplier
resource "configcat_setting" "price_multiplier" {
  config_id = data.configcat_configs.my_configs.configs.0.config_id
  key = "priceMultiplier"
  name = "Price Multiplier"
  hint = "Dynamic pricing multiplier for A/B testing"
  setting_type = "double"
  order = 3
}

resource "configcat_setting_value" "price_multiplier_value" {
  environment_id = data.configcat_environments.my_environments.environments.0.environment_id
  setting_id = configcat_setting.price_multiplier.id
  value = "1.25"
}

// Integer type feature flag - Max items per page
resource "configcat_setting" "max_items_per_page" {
  config_id = data.configcat_configs.my_configs.configs.0.config_id
  key = "maxItemsPerPage"
  name = "Maximum Items Per Page"
  hint = "Controls pagination size in list views"
  setting_type = "int"
  order = 4
}

resource "configcat_setting_value" "max_items_per_page_value" {
  environment_id = data.configcat_environments.my_environments.environments.0.environment_id
  setting_id = configcat_setting.max_items_per_page.id
  value = "50"
}

// JSON type feature flag - Complex configuration object
resource "configcat_setting" "ui_configuration" {
  config_id = data.configcat_configs.my_configs.configs.0.config_id
  key = "uiConfiguration"
  name = "UI Configuration"
  hint = "Complex JSON configuration for UI components"
  setting_type = "json"
  order = 5
}

resource "configcat_setting_value" "ui_configuration_value" {
  environment_id = data.configcat_environments.my_environments.environments.0.environment_id
  setting_id = configcat_setting.ui_configuration.id
  value = jsonencode({
    theme = "dark"
    layout = "sidebar"
    features = {
      search = true
      filters = true
      export = false
    }
    limits = {
      maxResults = 100
      timeout = 30
    }
  })
}

// Advanced String type - HTML content
resource "configcat_setting" "html_banner" {
  config_id = data.configcat_configs.my_configs.configs.0.config_id
  key = "htmlBannerContent"
  name = "HTML Banner Content"
  hint = "Rich HTML content for promotional banners"
  setting_type = "string"
  order = 6
}

resource "configcat_setting_value" "html_banner_value" {
  environment_id = data.configcat_environments.my_environments.environments.0.environment_id
  setting_id = configcat_setting.html_banner.id
  value = "<div class='banner'><h2>🎉 New Feature Available!</h2><p>Try our enhanced dashboard today.</p></div>"
}

// Advanced Double type - Percentage with high precision
resource "configcat_setting" "discount_percentage" {
  config_id = data.configcat_configs.my_configs.configs.0.config_id
  key = "discountPercentage"
  name = "Discount Percentage"
  hint = "Precise discount percentage for promotions"
  setting_type = "double"
  order = 7
}

resource "configcat_setting_value" "discount_percentage_value" {
  environment_id = data.configcat_environments.my_environments.environments.0.environment_id
  setting_id = configcat_setting.discount_percentage.id
  value = "12.75"
}

// Advanced Integer type - Feature limits
resource "configcat_setting" "feature_limits" {
  config_id = data.configcat_configs.my_configs.configs.0.config_id
  key = "featureLimits"
  name = "Feature Usage Limits"
  hint = "Various integer limits for feature usage"
  setting_type = "int"
  order = 8
}

resource "configcat_setting_value" "feature_limits_value" {
  environment_id = data.configcat_environments.my_environments.environments.0.environment_id
  setting_id = configcat_setting.feature_limits.id
  value = "1000"
}

// Advanced JSON type - Nested configuration with arrays
resource "configcat_setting" "advanced_config" {
  config_id = data.configcat_configs.my_configs.configs.0.config_id
  key = "advancedConfiguration"
  name = "Advanced System Configuration"
  hint = "Complex nested configuration with arrays and objects"
  setting_type = "json"
  order = 9
}

resource "configcat_setting_value" "advanced_config_value" {
  environment_id = data.configcat_environments.my_environments.environments.0.environment_id
  setting_id = configcat_setting.advanced_config.id
  value = jsonencode({
    api = {
      version = "v2"
      endpoints = [
        "/users",
        "/products",
        "/orders"
      ]
      rateLimit = {
        requests = 1000
        window = "1h"
      }
    }
    cache = {
      enabled = true
      ttl = 3600
      strategies = ["lru", "ttl"]
    }
    monitoring = {
      metrics = ["cpu", "memory", "disk"]
      alerts = {
        cpu_threshold = 80
        memory_threshold = 85
      }
    }
  })
}

// Edge case: Very long string value
resource "configcat_setting" "long_description" {
  config_id = data.configcat_configs.my_configs.configs.0.config_id
  key = "longDescription"
  name = "Long Description Field"
  hint = "Testing very long string values"
  setting_type = "string"
  order = 10
}

resource "configcat_setting_value" "long_description_value" {
  environment_id = data.configcat_environments.my_environments.environments.0.environment_id
  setting_id = configcat_setting.long_description.id
  value = "This is a very long description that tests the maximum length limits of ConfigCat string settings. It contains multiple sentences and should help validate how the system handles large text content. We're testing various edge cases including special characters, numbers, and punctuation marks. The goal is to understand the limitations and behavior of the Terraform provider when dealing with complex string values."
}

// Edge case: Very large JSON object
resource "configcat_setting" "large_json_config" {
  config_id = data.configcat_configs.my_configs.configs.0.config_id
  key = "largeJsonConfiguration"
  name = "Large JSON Configuration"
  hint = "Testing very large JSON objects"
  setting_type = "json"
  order = 11
}

resource "configcat_setting_value" "large_json_config_value" {
  environment_id = data.configcat_environments.my_environments.environments.0.environment_id
  setting_id = configcat_setting.large_json_config.id
  value = jsonencode({
    data = {
      users = {
        fields = ["id", "name", "email", "role", "created_at", "updated_at", "last_login", "status", "preferences", "metadata"]
        validation = {
          required = ["id", "name", "email"]
          email_format = true
          name_min_length = 2
          name_max_length = 100
        }
      }
      products = {
        fields = ["id", "name", "description", "price", "category", "tags", "inventory", "supplier", "ratings", "reviews"]
        validation = {
          required = ["id", "name", "price"]
          price_min = 0.01
          price_max = 999999.99
        }
      }
      orders = {
        fields = ["id", "user_id", "items", "total", "status", "created_at", "shipping_address", "billing_address", "payment_method", "notes"]
        validation = {
          required = ["id", "user_id", "items", "total"]
          total_min = 0.01
        }
      }
    }
    settings = {
      pagination = {
        default_page_size = 20
        max_page_size = 100
        page_size_options = [10, 20, 50, 100]
      }
      search = {
        enabled = true
        min_query_length = 2
        max_results = 1000
        highlight = true
      }
      notifications = {
        email = true
        push = true
        sms = false
        webhook = true
      }
    }
  })
}
