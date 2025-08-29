# INPUT VARIABLES
variable "config_id" {
  description = "The ConfigCat config ID from the parent configuration"
  type        = string
}

variable "prod_environment_id" {
  description = "The ConfigCat prod environment ID"
  type        = string
}

variable "forno_environment_id" {
  description = "The ConfigCat forno environment ID"
  type        = string
}

variable "staging_environment_id" {
  description = "The ConfigCat staging environment ID"
  type        = string
}

variable "configcat_basic_auth_username" {
  description = "ConfigCat Basic Auth Username"
  type        = string
  default     = ""
  sensitive   = true
}

variable "configcat_basic_auth_password" {
  description = "ConfigCat Basic Auth Password"
  type        = string
  default     = ""
  sensitive   = true
}
