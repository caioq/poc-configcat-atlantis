# Infrastructure Management
#
# TO CREATE NEW INFRASTRUCTURE:
# 1. Rename this file to: infrastructure.tf.disabled
# 2. Rename create-infrastructure.tf to: infrastructure.tf
# 3. Run: terraform apply
# 4. After creation, reverse the file names
#
# TO USE EXISTING INFRASTRUCTURE:
# 1. Keep this file as: infrastructure.tf
# 2. Keep create-infrastructure.tf as: create-infrastructure.tf
# 3. This will automatically use existing infrastructure

# Data sources to reference existing infrastructure
data "configcat_configs" "existing_configs" {
  product_id = data.configcat_products.my_products.products.0.product_id
  name_filter_regex = "My config v2"
}

data "configcat_segments" "existing_segments" {
  product_id = data.configcat_products.my_products.products.0.product_id
  name_filter_regex = "Beta users"
}

# Local values for easy reference
locals {
  config_id = data.configcat_configs.existing_configs.configs.0.config_id
  segment_id = data.configcat_segments.existing_segments.segments.0.segment_id
}
