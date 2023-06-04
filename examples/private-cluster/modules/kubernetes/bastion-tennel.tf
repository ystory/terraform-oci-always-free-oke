resource "null_resource" "bastion_tunnel" {
  depends_on = [null_resource.kubeconfig, local_file.bastion_tunnel]

  triggers = {
    always_run = uuid()
  }

  provisioner "local-exec" {
    command = local_file.bastion_tunnel.filename
  }
}

resource "local_file" "bastion_tunnel" {
  depends_on = [local_file.id_rsa, local_file.id_rsa_pub]
  content    = templatefile("${path.module}/scripts/create_bastion_tunnel_template.sh",
    {
      bastion_id       = var.control_plane_bastion_service_id
      public_key_file  = local_file.id_rsa_pub.filename
      private_key_file = local_file.id_rsa.filename
      cluster_ip       = local.private_endpoint_ip
      cluster_port     = local.private_endpoint_port
      region           = var.region
    }
  )
  filename = "${path.root}/connect_to_cluster.sh"
}

resource "local_file" "id_rsa" {
  content         = local.ssh_private_key
  filename        = "${path.root}/id_rsa"
  file_permission = "0600"
}

resource "local_file" "id_rsa_pub" {
  content         = local.ssh_authorized_keys
  filename        = "${path.root}/id_rsa.pub"
  file_permission = "0600"
}
