# variable "configcat_username" {
#   description = "ConfigCat Basic Auth Username"
#   type        = string
#   default     = ""
#   sensitive   = true
# }

# variable "configcat_password" {
#   description = "ConfigCat Basic Auth Password"
#   type        = string
#   default     = ""
#   sensitive   = true
# }

variable "configcat_config_name" {
  description = "ConfigCat Config Name"
  type        = string
  default     = "Main Config"
}
