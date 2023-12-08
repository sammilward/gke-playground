resource "google_service_account" "default_gke" {
  project      = google_project.project.name
  account_id   = "default-gke"
  display_name = "default-gke"
  depends_on   = [google_project.project]
}

resource "google_artifact_registry_repository_iam_member" "member" {
  project      = google_project.project.name
  location = google_artifact_registry_repository.my-repo.location
  repository = google_artifact_registry_repository.my-repo.name
  role = "roles/artifactregistry.reader"
  member = "serviceAccount:${google_service_account.default_gke.email}"
}