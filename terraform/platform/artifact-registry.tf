resource "google_artifact_registry_repository" "my-repo" {
  project       = google_project.project.name
  location      = var.region
  repository_id = "sams-registry"
  description   = "sams registry"
  format        = "DOCKER"

  docker_config {
    immutable_tags = true
  }
}
