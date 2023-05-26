module "oke" {
  source  = "oracle-terraform-modules/oke/oci"
  version = "4.5.9"

  home_region = var.home_region
  region      = var.region

  tenancy_ocid = var.tenancy_ocid

  # ssh keys
  ssh_private_key_path = var.ssh_private_key_path
  ssh_public_key_path  = var.ssh_public_key_path

  # general oci parameters
  compartment_id = oci_identity_compartment._.id
  label_prefix   = var.label_prefix

  # networking
  create_drg                   = false
  internet_gateway_route_rules = []
  nat_gateway_route_rules      = []

  vcn_cidrs     = ["10.0.0.0/16"]
  vcn_name      = var.name

  # bastion host
  create_bastion_host = false

  # bastion service
  create_bastion_service = true
  bastion_service_target_subnet = "control-plane"

  # operator host
  create_operator                    = false

  # oke cluster options
  cluster_name                = var.name
  control_plane_allowed_cidrs = ["0.0.0.0/0"]
  kubernetes_version          = "v1.26.2"
  dashboard_enabled           = true
  cluster_type                = "basic"
  control_plane_type          = "private"

  # node pools
  node_pools = {
    np1 = {
      shape = "VM.Standard.A1.Flex", ocpus = 2, memory = 12, node_pool_size = 2, boot_volume_size = 50,
      label = { pool = "np1" }
    }
  }
  node_pool_name_prefix = var.name

  # oke load balancers
  load_balancers          = "both"
  preferred_load_balancer = "public"
  public_lb_allowed_cidrs = ["0.0.0.0/0"]
  public_lb_allowed_ports = [80, 443]

  providers = {
    oci.home = oci
  }
}
