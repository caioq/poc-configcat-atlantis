variable "configcat_product_name" {
  type = string
}

resource "configcat_segment" "my_segment" {
  product_id           = var.configcat_product_name
  name                 = "Beta users"
  description          = "Beta users' description"
  comparison_attribute = "email"
  comparator           = "sensitiveIsOneOf"
  comparison_value     = "betauser1@example.com,betauser2@example.com"
}


output "segment_id" {
  value = configcat_segment.my_segment.id
}
