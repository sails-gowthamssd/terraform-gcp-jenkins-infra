output "cluster_name" {
  description = "Name of the GKE cluster"
  value       = module.gke.cluster_name
}

output "docker_service_account" {
  value = module.service_accounts.docker_sa_email
}

output "helm_service_account" {
  value = module.service_accounts.helm_sa_email
}

output "artifact_repo_name" {
  value = module.artifact_registry.repo_name
}