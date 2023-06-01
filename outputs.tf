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
