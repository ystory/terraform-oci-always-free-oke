locals {
  max_cores_free_tier     = 4
  max_memory_free_tier_gb = 24

  api_private_key = (
  var.api_private_key != ""
  ? try(base64decode(var.api_private_key), var.api_private_key)
  : var.api_private_key_path != ""
  ? file(var.api_private_key_path)
  : null)
}