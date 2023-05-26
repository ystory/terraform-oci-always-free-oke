data "oci_core_images" "oracle_images" {
  compartment_id           = oci_identity_compartment._.id
  operating_system         = "Oracle Linux"
  operating_system_version = 8
  shape                    = "VM.Standard.E2.1.Micro"
  sort_by                  = "TIMECREATED"
  sort_order               = "DESC"
}
