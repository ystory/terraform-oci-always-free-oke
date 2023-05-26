resource "oci_identity_compartment" "_" {
  name          = var.name
  description   = "Terraform-deployed Kubernetes cluster using free resources."
  enable_delete = true
}
