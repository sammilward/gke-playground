resource "google_project" "state_project" {
  name            = "sams-terraform-state"
  project_id      = "sams-terraform-state"
  billing_account = var.billing_account
}

locals {
  state_project_services = toset([
    "storage.googleapis.com"
  ])
}

resource "google_project_service" "state_services" {
  for_each   = local.state_project_services
  project    = google_project.state_project.id
  service    = each.key
  depends_on = [google_project.state_project]
}

resource "google_project" "service_project" {
  name            = var.service_project_name
  project_id      = var.service_project_name
  billing_account = var.billing_account
}

locals {
  service_project_services = toset([
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

resource "google_project_service" "service_project_services" {
  for_each                   = local.service_project_services
  project                    = google_project.service_project.name
  service                    = each.key
  disable_dependent_services = true
  depends_on                 = [google_project.service_project]
}
