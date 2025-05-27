resource "google_service_account" "docker_sa" {
  account_id   = var.docker_sa_name
  display_name = "Docker Builder SA"
  project      = var.project_id
}

resource "google_service_account" "helm_sa" {
  account_id   = var.helm_sa_name
  display_name = "Helm Deployer SA"
  project      = var.project_id
}

resource "google_project_iam_member" "docker_registry_push" {
  project = var.project_id
  role    = var.docker_role
  member  = "serviceAccount:${google_service_account.docker_sa.email}"
}

resource "google_project_iam_member" "helm_gke_access" {
  project = var.project_id
  role    = var.helm_role
  member  = "serviceAccount:${google_service_account.helm_sa.email}"
}

resource "google_service_account_iam_binding" "docker_bind" {
  service_account_id = google_service_account.docker_sa.name
  role               = var.workload_identity_role

  members = [
    "serviceAccount:${var.project_id}.svc.id.goog[${var.namespace}/docker-ksa]"
  ]
}

resource "google_service_account_iam_binding" "helm_bind" {
  service_account_id = google_service_account.helm_sa.name
  role               = var.workload_identity_role

  members = [
    "serviceAccount:${var.project_id}.svc.id.goog[${var.namespace}/helm-ksa]"
  ]
}
