output "docker_sa_email" {
  value = google_service_account.docker_sa.email
}

output "helm_sa_email" {
  value = google_service_account.helm_sa.email
}