resource "google_artifact_registry_repository" "registry" {
  project       = var.service_project_name
  location      = var.region
  repository_id = var.registry_name
  description   = "sams-docker-registry"
  format        = "DOCKER"

  docker_config {
    immutable_tags = true
  }

  depends_on = [ google_project_service.service_project_services["storage.googleapis.com"] ]
}
