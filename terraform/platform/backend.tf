terraform {
  backend "gcs" {
    bucket = "terraform-state-12345"
    prefix = "terraform/state"
  }
}