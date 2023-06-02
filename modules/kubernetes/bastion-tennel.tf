variable "always_run_bastion_tunnel" {
  description = "A boolean variable to decide whether to always trigger the bastion_tunnel null_resource on each 'terraform apply'. Set to 'true' to always trigger, and 'false' to maintain the trigger state."
  default     = true
}

locals {
  trigger_value_bastion_tunnel = var.always_run_bastion_tunnel ? uuid() : ""
}

resource "null_resource" "bastion_tunnel" {
  depends_on = [null_resource.kubeconfig, local_file.bastion_tunnel]

  triggers = {
    always_run = local.trigger_value_bastion_tunnel
  }

  provisioner "local-exec" {
    command = "${path.root}/cluster_access.sh"
  }

  count = local.post_provisioning_ops_enabled ? 1 : 0
}

resource "local_file" "bastion_tunnel" {
  depends_on = [local_file.id_rsa, local_file.id_rsa_pub]
  content    = templatefile("${path.module}/scripts/create_bastion_tunnel_template.sh",
    {
      bastion_id       = var.control_plane_bastion_service_id
      public_key_file  = local_file.id_rsa_pub[0].filename
      private_key_file = local_file.id_rsa[0].filename
      cluster_ip       = local.private_endpoint_ip
      cluster_port     = local.private_endpoint_port
      region           = var.region
    }
  )
  filename = "${path.root}/cluster_access.sh"

  count = local.post_provisioning_ops_enabled ? 1 : 0
}

resource "local_file" "id_rsa" {
  content         = local.ssh_private_key
  filename        = "${path.root}/id_rsa"
  file_permission = "0600"

  count = local.post_provisioning_ops_enabled ? 1 : 0
}

resource "local_file" "id_rsa_pub" {
  content         = local.ssh_authorized_keys
  filename        = "${path.root}/id_rsa.pub"
  file_permission = "0600"

  count = local.post_provisioning_ops_enabled ? 1 : 0
}
