resource "null_resource" "kubeconfig" {
  depends_on = [local_file.create_kubeconfig]

  provisioner "local-exec" {
    command = "${path.root}/create_kubeconfig.sh"
  }

  count = local.post_provisioning_ops_enabled ? 1 : 0
}

resource "local_file" "create_kubeconfig" {
  content = templatefile("${path.module}/scripts/create_kubeconfig_template.sh",
    {
      cluster_id = var.cluster_id
      cluster_ip = local.private_endpoint_ip
      region     = var.region
    }
  )
  filename = "${path.root}/create_kubeconfig.sh"

  count = local.post_provisioning_ops_enabled ? 1 : 0
}
