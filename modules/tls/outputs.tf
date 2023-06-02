output "ssh_private_key" {
  value = local_file.ssh_private_key.content
}

output "ssh_public_key" {
  value = local_file.ssh_public_key.content
}

output "ssh_private_key_filename" {
  value = local_file.ssh_private_key.filename
}

output "ssh_public_key_filename" {
  value = local_file.ssh_public_key.filename
}
