output "cluster_endpoints" {
  description = "Endpoints for the Kubernetes cluster"
  value       = module.oke.cluster_endpoints
}

output "autoscaling_nodepools" {
  value = module.oke.autoscaling_nodepools
}

output "bastion_service_instance_id" {
  value = module.oke.bastion_service_instance_id
}
