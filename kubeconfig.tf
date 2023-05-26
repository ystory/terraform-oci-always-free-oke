resource "null_resource" "kubeconfig" {

  depends_on = [module.oke]

  provisioner "local-exec" {
    command = "${path.module}/scripts/create_kubeconfig.sh ${module.oke.cluster_id} ${split(":", element(module.oke.cluster_endpoints, 0)["private_endpoint"])[0]} ${var.region}"
  }
}
