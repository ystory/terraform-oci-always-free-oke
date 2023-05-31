locals {

  api_private_key = (
  var.api_private_key != ""
  ? try(base64decode(var.api_private_key), var.api_private_key)
  : var.api_private_key_path != ""
  ? file(var.api_private_key_path)
  : null)
}
