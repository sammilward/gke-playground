resource "google_project" "project" {
  name            = "sams-sandbox-projects-12345"
  project_id      = "sams-sandbox-projects-12345"
  billing_account = var.billing_account
}

locals {
  services = toset([
    "iam.googleapis.com",
    "compute.googleapis.com",
    "container.googleapis.com",
    "dns.googleapis.com",
    "gkehub.googleapis.com",
    "secretmanager.googleapis.com",
    "meshconfig.googleapis.com",
    "anthos.googleapis.com"
  ])
}

resource "google_project_service" "services" {
  for_each                   = local.services
  project                    = google_project.project.name
  service                    = each.key
  disable_dependent_services = true
  depends_on                 = [google_project.project]
}
