# general oci
variable "compartment_id" {}

variable "label_prefix" {}

# bastion service parameters
variable "bastion_service_access" {
  type = list(string)
}

variable "bastion_service_name" {}

variable "bastion_service_target_subnet" {}

variable "vcn_id" {}