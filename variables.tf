variable "name" {
  type    = string
  default = "k8s-on-oci"
}

variable "ssh_private_key_path" {
  description = "The path to ssh private key."
  type        = string
}

variable "ssh_public_key_path" {
  description = "The path to ssh public key."
  type        = string
}

variable "home_region" {
  # List of regions: https://docs.cloud.oracle.com/iaas/Content/General/Concepts/regions.htm#ServiceAvailabilityAcrossRegions
  description = "The tenancy's home region. Required to perform identity operations."
  type        = string
}

variable "region" {
  # List of regions: https://docs.cloud.oracle.com/iaas/Content/General/Concepts/regions.htm#ServiceAvailabilityAcrossRegions
  description = "The OCI region where OKE resources will be created."
  type        = string
}

variable "tenancy_ocid" {
  description = "The tenancy id of the OCI Cloud Account in which to create the resources."
  type        = string
}

variable "label_prefix" {
  default     = "none"
  description = "A string that will be prepended to all resources."
  type        = string
}
