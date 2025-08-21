variable "configcat_basic_auth_username" {
  description = "ConfigCat Basic Auth Username"
  type        = string
}

variable "configcat_basic_auth_password" {
  description = "ConfigCat Basic Auth Password"
  type        = string
  sensitive   = true
}

variable "configcat_config_name" {
  description = "ConfigCat Config Name"
  type        = string
  default     = "Main Config"
}
