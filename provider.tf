provider "oci" {
  fingerprint  = var.api_fingerprint
  private_key  = local.api_private_key
  region       = var.home_region
  tenancy_ocid = var.tenancy_id
  user_ocid    = var.user_id
}
