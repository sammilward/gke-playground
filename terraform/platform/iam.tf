resource "google_service_account" "default_gke" {
  project      = google_project.project.name
  account_id   = "default-gke"
  display_name = "default-gke"
  depends_on   = [google_project.project]
}
