resource "null_resource" "ingress_nginx" {

  depends_on = [null_resource.bastion_tunnel]

  provisioner "local-exec" {
    command = "kubectl --kubeconfig ~/.kube/ociconfig apply -f k8s-resources/ingress-nginx-deployment.yaml"
  }

  provisioner "local-exec" {
    when    = destroy
    command = "kubectl --kubeconfig ~/.kube/ociconfig delete -f k8s-resources/ingress-nginx-deployment.yaml"
  }
}