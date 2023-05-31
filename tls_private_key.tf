resource "tls_private_key" "key" {
  count = var.create_ssh_key_pair ? 1 : 0
  algorithm = "RSA"
  rsa_bits  = "4096"
}

resource "local_file" "ssh_private_key" {
  count = var.create_ssh_key_pair ? 1 : 0
  content         = tls_private_key.key[0].private_key_pem
  filename        = "${abspath(path.root)}/id_rsa"
  file_permission = "0600"
}

resource "local_file" "ssh_public_key" {
  count = var.create_ssh_key_pair ? 1 : 0
  content         = tls_private_key.key[0].public_key_openssh
  filename        = "${abspath(path.root)}/id_rsa.pub"
  file_permission = "0600"
}
