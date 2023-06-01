resource "oci_bastion_bastion" "bastion" {
  bastion_type                 = "STANDARD"
  compartment_id               = var.compartment_id
  target_subnet_id             = var.bastion_service_target_subnet
  client_cidr_block_allow_list = var.bastion_service_access
  name                         = var.bastion_service_name
}
