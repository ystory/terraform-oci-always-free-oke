output "cluster_id" {
  description = "ID of the Kubernetes cluster"
  value       = module.oke.cluster_id
}

output "cluster_endpoints" {
  description = "Endpoints for the Kubernetes cluster"
  value       = module.oke.cluster_endpoints
}

output "bastion_ids" {
  description = "Map of Bastion Service IDs (cp, workers)"
  value       = {
    "cp"      = module.bastion_service_control_plane.bastion_id
    "workers" = module.bastion_service_workers.bastion_id
  }
}

output "nodepool_ids" {
  description = "Map of Nodepool names and IDs"
  value       = module.oke.nodepool_ids
}

output "compartment_id" {
  description = "The OCID of the compartment that is using Oracle Cloud's Always Free services"
  value       = module.compartment.compartment_id
}

output "vcn_id" {
  description = "The OCID of the Virtual Cloud Network (VCN) created within the compartment using Oracle Cloud's Always Free services."
  value       = module.oke.vcn_id
}
