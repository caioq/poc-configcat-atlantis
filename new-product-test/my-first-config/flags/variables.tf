# INPUT VARIABLES
variable "config_id" {
  description = "The ConfigCat config ID from the parent configuration"
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
