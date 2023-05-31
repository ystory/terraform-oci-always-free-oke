module "free-k8s" {
  source = "../../"

  tenancy_id  = var.tenancy_id
  home_region = var.home_region
  region      = var.region

  node_pool_size = 2

  kubernetes_version          = "v1.26.2"
  control_plane_type          = "private"
  control_plane_allowed_cidrs = ["0.0.0.0/0"]

  create_ssh_key_pair = true

  providers = {
    oci.home = oci.home
  }
}
