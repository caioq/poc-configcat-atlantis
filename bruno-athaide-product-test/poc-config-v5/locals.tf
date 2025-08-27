# Local values for config v5
locals {
  config_name = "POC Config v5"
}

output "config_name" {
  description = "The config name from config v5"
  value       = local.config_name
}
