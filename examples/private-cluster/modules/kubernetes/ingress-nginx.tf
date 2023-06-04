resource "null_resource" "ingress_nginx" {

  depends_on = [null_resource.bastion_tunnel]

  provisioner "local-exec" {
    command = "kubectl --kubeconfig ~/.kube/ociconfig apply -f ${path.module}/resources/ingress-nginx-deployment.yaml"
  }

  provisioner "local-exec" {
    when    = destroy
    command = "${path.root}/create_kubeconfig.sh"
  }

  provisioner "local-exec" {
    when    = destroy
    command = "${path.root}/connect_to_cluster.sh"
  }

  provisioner "local-exec" {
    when    = destroy
    command = "kubectl --kubeconfig ~/.kube/ociconfig delete -f ${path.module}/resources/ingress-nginx-deployment.yaml"
  }
}
