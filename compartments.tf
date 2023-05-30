resource "oci_identity_compartment" "_" {
  name          = var.name
  description   = "Compartment for the Oracle Cloud Always Free Kubernetes Cluster created using Terraform module."
  enable_delete = true
}
