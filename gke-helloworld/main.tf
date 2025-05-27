terraform {
  required_version = ">= 1.3.0"

  required_providers {
    google = {
      source  = "hashicorp/google"
      version = ">= 5.0"
    }
  }

  backend "gcs" {
    bucket = "gowtham-iron-bucket"
    prefix = "gke-jenkins-helloworld/state"
  }
}

provider "google" {
  project = var.project_id
  region  = var.region
}

module "gke" {
  source       = "../modules/gke"
  project_id = var.project_id
  cluster_name = var.cluster_name
  region       = var.zone
}

module "service_accounts" {
  source                  = "./modules/service_accounts"
  project_id              = var.project_id
  namespace               = var.k8s_namespace
  cluster_name            = var.cluster_name
  cluster_location        = var.zone
  docker_sa_name          = "docker-pusher"
  helm_sa_name            = "helm-deployer"
  docker_role             = "roles/artifactregistry.writer"
  helm_role               = "roles/container.developer"
  workload_identity_role  = "roles/iam.workloadIdentityUser"
}
module "artifact_registry" {
  source      = "../modules/artifact_registry"
  repo_name   = "hello-world-jenkins-repo"
  region      = var.region
  description = "Docker repo for HelloWorld app"
}