resource "google_container_cluster" "gke" {
  name               = var.cluster_name
  location           = var.region
  remove_default_node_pool = true
  initial_node_count = 1
  workload_identity_config {
    workload_pool = "${var.project_id}.svc.id.goog"
  }
}

resource "google_container_node_pool" "primary" {
  name     = "primary-jenkins-node-pool"
  cluster  = google_container_cluster.gke.name
  location = var.region
  node_count = 1

  node_config {
    machine_type = "e2-medium"
    disk_size_gb = 50              # << Reduce from default 100 to 50
    disk_type    = "pd-ssd"        # Still SSD, just smaller
    oauth_scopes = [
      "https://www.googleapis.com/auth/cloud-platform"
    ]
  }
}
