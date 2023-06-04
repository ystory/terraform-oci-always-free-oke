module "tls" {
  source = "./modules/tls"

  count = var.create_ssh_key_pair == true ? 1 : 0
}

module "free_k8s" {
  source = "../../"
  #  version = "0.0.5"

  tenancy_id  = var.tenancy_id
  home_region = var.home_region
  region      = var.region

  node_pool_size = 2

  kubernetes_version          = "v1.26.2"
  control_plane_type          = "private"
  control_plane_allowed_cidrs = ["0.0.0.0/0"]

  providers = {
    oci.home = oci.home
  }
}

module "kubernetes" {
  source = "./modules/kubernetes"

  control_plane_bastion_service_id = module.free_k8s.bastion_ids["cp"]
  workers_bastion_service_id       = module.free_k8s.bastion_ids["workers"]

  # ssh keys
  ssh_private_key      = var.create_ssh_key_pair ? chomp(module.tls[0].ssh_private_key) : var.ssh_private_key
  ssh_private_key_path = var.ssh_private_key_path
  ssh_public_key       = var.create_ssh_key_pair ? chomp(module.tls[0].ssh_public_key) : var.ssh_public_key
  ssh_public_key_path  = var.ssh_public_key_path


  cluster_id        = module.free_k8s.cluster_id
  cluster_endpoints = module.free_k8s.cluster_endpoints

  region = var.region
}
