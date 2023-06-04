module "compartment" {
  source = "./modules/compartment"

  name = var.name
}

module "oke" {
  source  = "oracle-terraform-modules/oke/oci"
  version = "4.5.9"

  tenancy_id = var.tenancy_id

  region      = var.region
  home_region = var.home_region

  # ssh keys
  ssh_private_key      = var.ssh_private_key
  ssh_private_key_path = var.ssh_private_key_path
  ssh_public_key       = var.ssh_public_key
  ssh_public_key_path  = var.ssh_public_key_path

  # general oci parameters
  compartment_id = module.compartment.compartment_id
  label_prefix   = var.label_prefix

  # bastion host
  create_bastion_host = false

  # operator host
  create_operator = false

  # oke cluster options
  cluster_name                = var.name
  control_plane_allowed_cidrs = var.control_plane_allowed_cidrs
  kubernetes_version          = var.kubernetes_version
  dashboard_enabled           = true
  cluster_type                = "basic"
  control_plane_type          = var.control_plane_type

  # node pools
  node_pools = {
    arm-ampere-a1-free-tier = {
      shape            = "VM.Standard.A1.Flex",
      ocpus            = local.max_cores_free_tier / var.node_pool_size,
      memory           = local.max_memory_free_tier_gb / var.node_pool_size,
      node_pool_size   = var.node_pool_size,
      boot_volume_size = 50,
      label            = {
        pool         = "arm-ampere-a1-free-tier",
        architecture = "arm",
        pool-type    = "free-tier",
        processor    = "ampere-a1",
        shape        = "VM.Standard.A1.Flex",
        region       = var.home_region
      }
    }
  }

  # oke load balancers
  load_balancers          = "both"
  preferred_load_balancer = "public"
  public_lb_allowed_ports = [80, 443]

  providers = {
    oci.home = oci.home
  }
}

module "bastion_service_control_plane" {
  source = "./modules/bastion-service"

  # general oci parameters
  compartment_id = module.compartment.compartment_id
  label_prefix   = var.label_prefix

  # bastion service parameters
  bastion_service_access        = var.bastion_service_access
  bastion_service_name          = "${var.name}-cp"
  bastion_service_target_subnet = module.oke.subnet_ids["cp"]
  vcn_id                        = module.oke.vcn_id
}

module "bastion_service_workers" {
  source = "./modules/bastion-service"

  # general oci parameters
  compartment_id = module.compartment.compartment_id
  label_prefix   = var.label_prefix

  # bastion service parameters
  bastion_service_access        = var.bastion_service_access
  bastion_service_name          = "${var.name}-workers"
  bastion_service_target_subnet = module.oke.subnet_ids["workers"]
  vcn_id                        = module.oke.vcn_id
}
