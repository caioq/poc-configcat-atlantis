variable "product_id" {
  type = string
}

resource "configcat_config" "my_config" {
  product_id         = var.product_id
  name               = "My config v2"
  description        = "My config description"
  order              = 0
  evaluation_version = "v2"
}


output "config_id" {
  value = configcat_config.my_config.id
}
