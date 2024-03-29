resource "google_compute_network" "vpc_network" {
  project                 = google_project.project.name
  name                    = "gke-net"
  auto_create_subnetworks = false
  depends_on              = [google_project_service.services["compute.googleapis.com"]]
}

resource "google_compute_subnetwork" "gke" {
  project       = var.project_id
  name          = "gke"
  ip_cidr_range = "10.2.0.0/16"
  region        = var.region
  network       = google_compute_network.vpc_network.id
  secondary_ip_range {
    range_name    = "pods"
    ip_cidr_range = "192.168.10.0/24"
  }
  secondary_ip_range {
    range_name    = "services"
    ip_cidr_range = "192.168.11.0/24"
  }
  depends_on = [google_compute_network.vpc_network]
}
