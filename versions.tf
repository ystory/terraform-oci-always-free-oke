terraform {
  required_version = ">= 1.2.0"

  required_providers {
    oci = {
      source                = "oracle/oci"
      configuration_aliases = [oci.home]
      version               = "5.6.0"
    }
  }
}
