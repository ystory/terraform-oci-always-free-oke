resource "null_resource" "create_service_account" {
  depends_on = [null_resource.bastion_tunnel]

  provisioner "local-exec" {
    command = "kubectl --kubeconfig ~/.kube/ociconfig apply -f ${path.module}/resources/oke-admin-service-account.yaml"
  }

  provisioner "local-exec" {
    command = "kubectl --kubeconfig ~/.kube/ociconfig apply -f ${path.module}/resources/oke-admin-service-account-token.yaml"
  }

  count = local.post_provisioning_ops_enabled ? 1 : 0
}
