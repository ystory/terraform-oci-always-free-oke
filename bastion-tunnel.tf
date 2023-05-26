variable "always_run_bastion_tunnel" {
  description = "A boolean variable to decide whether to always trigger the bastion_tunnel null_resource on each 'terraform apply'. Set to 'true' to always trigger, and 'false' to maintain the trigger state."
  default     = true
}

locals {
  trigger_value_bastion_tunnel = var.always_run_bastion_tunnel ? uuid() : ""
}

resource "null_resource" "bastion_tunnel" {
  triggers = {
    always_run = local.trigger_value_bastion_tunnel
  }

  depends_on = [null_resource.kubeconfig]

  provisioner "local-exec" {
    command = "${path.module}/scripts/create_bastion_tunnel.sh ${module.oke.bastion_service_instance_id} ${var.ssh_public_key_path} ${var.ssh_private_key_path} ${split(":", element(module.oke.cluster_endpoints, 0)["private_endpoint"])[0]} ${split(":", element(module.oke.cluster_endpoints, 0)["private_endpoint"])[1]} ${var.region}"
  }
}
