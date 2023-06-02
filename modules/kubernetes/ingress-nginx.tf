resource "null_resource" "ingress_nginx" {

  depends_on = [null_resource.bastion_tunnel]

  provisioner "local-exec" {
    command = "kubectl --kubeconfig ~/.kube/ociconfig apply -f ${path.module}/resources/ingress-nginx-deployment.yaml"
  }

  provisioner "local-exec" {
    when    = destroy
    command = "kubectl --kubeconfig ~/.kube/ociconfig delete -f ${path.module}/resources/ingress-nginx-deployment.yaml"
  }

  count = local.post_provisioning_ops_enabled ? 1 : 0
}
