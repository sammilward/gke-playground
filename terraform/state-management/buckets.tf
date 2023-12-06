resource "google_storage_bucket" "state" {
  project                  = "sams-teraform-state"
  name                     = "terraform-state-12345"
  location                 = "EU"
  force_destroy            = true
  public_access_prevention = "enforced"
  depends_on               = [google_project.project]
  versioning {
    enabled = true
  }
}
