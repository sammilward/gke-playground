resource "google_storage_bucket" "state" {
  project                  = "sams-terraform-state"
  name                     = "terraform-state-12345"
  location                 = "EU"
  force_destroy            = true
  public_access_prevention = "enforced"
  depends_on               = [google_project_service.service_project_services["storage.googleapis.com"]]
  versioning {
    enabled = true
  }
}
