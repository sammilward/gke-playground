resource "google_project" "project" {
  name            = "sams-teraform-state"
  project_id      = "sams-teraform-state"
  billing_account = var.billing_account
}

locals {
  services = toset([
    "storage.googleapis.com"
  ])
}

resource "google_project_service" "services" {
  for_each   = local.services
  project    = google_project.project.id
  service    = each.key
  depends_on = [google_project.project]
}
