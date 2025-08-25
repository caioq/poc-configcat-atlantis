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
  default     = ""  # Empty default - will be provided by calling modules
}
