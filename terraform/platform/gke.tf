resource "google_container_cluster" "cluster1" {
  project                  = google_project.project.name
  name                     = "cluster1"
  location                 = var.region
  remove_default_node_pool = true
  initial_node_count       = 1
  workload_identity_config {
    workload_pool = "${google_project.project.name}.svc.id.goog"
  }
  depends_on = [google_project_service.services["container.googleapis.com"]]
  node_config {
    disk_size_gb = 10
  }
  deletion_protection = false
}

resource "google_container_node_pool" "cluster1_primary" {
  project    = google_project.project.name
  name       = "primary"
  location   = var.region
  cluster    = google_container_cluster.cluster1.name
  node_count = 3

  node_config {
    disk_size_gb = 50
    preemptible  = true
    machine_type = "e2-small"

    service_account = google_service_account.default_gke.email
    oauth_scopes = [
      "https://www.googleapis.com/auth/cloud-platform"
    ]

    tags = ["gke-primary"]

    labels = {
      "nodepool" = "primary"
    }
  }
  depends_on = [google_container_cluster.cluster1, google_service_account.default_gke]
}
