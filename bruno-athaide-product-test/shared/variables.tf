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

variable "configcat_product_name" {
  description = "ConfigCat Product Name"
  type        = string
  default     = "Bruno Athaide Product Test"
}

variable "configcat_config_name" {
  description = "ConfigCat Config Name"
  type        = string
  default     = "Caio Config"
}

variable "configcat_product_id" {
  description = "ConfigCat Product ID"
  type        = string
}
