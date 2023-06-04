resource "null_resource" "kubeconfig" {
  depends_on = [local_file.create_kubeconfig]

  triggers = {
    always_run = uuid()
  }

  provisioner "local-exec" {
    command = local_file.create_kubeconfig.filename
  }
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
}
