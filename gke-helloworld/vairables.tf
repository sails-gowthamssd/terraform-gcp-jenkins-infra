variable "project_id" {}
variable "region" {
  default = "us-central1"
}
variable "zone" {
  default = "us-central1-c"
}
variable "cluster_name" {
  default = "hello-gke"
}
variable "k8s_namespace" {
  type = string
}