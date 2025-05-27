variable "repo_name" {
  description = "Name of the Artifact Registry repository"
  type        = string
}

variable "region" {
  description = "Region for the Artifact Registry"
  type        = string
}

variable "description" {
  description = "Description of the repository"
  type        = string
  default     = ""
}
