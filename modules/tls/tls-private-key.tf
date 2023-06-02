resource "tls_private_key" "key" {
  algorithm = "RSA"
  rsa_bits  = "4096"
}

resource "local_file" "ssh_private_key" {
  content         = tls_private_key.key.private_key_pem
  filename        = "${abspath(path.root)}/id_rsa"
  file_permission = "0600"
}

resource "local_file" "ssh_public_key" {
  content         = tls_private_key.key.public_key_openssh
  filename        = "${abspath(path.root)}/id_rsa.pub"
  file_permission = "0600"
}
