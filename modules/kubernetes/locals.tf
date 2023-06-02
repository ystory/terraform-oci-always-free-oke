locals {
  # TODO
  post_provisioning_ops_enabled = true

  private_endpoint_ip   = split(":", element(var.cluster_endpoints, 0)["private_endpoint"])[0]
  private_endpoint_port = split(":", element(var.cluster_endpoints, 0)["private_endpoint"])[1]
}
