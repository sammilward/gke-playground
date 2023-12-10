resource "google_service_account" "default_gke" {
  project      = var.service_project_name
  account_id   = "default-gke"
  display_name = "default-gke"
}

resource "google_artifact_registry_repository_iam_member" "member" {
  project    = var.service_project_name
  location   = var.region
  repository = var.registry_name
  role       = "roles/artifactregistry.reader"
  member     = "serviceAccount:${google_service_account.default_gke.email}"
  depends_on = [google_service_account.default_gke]
}
