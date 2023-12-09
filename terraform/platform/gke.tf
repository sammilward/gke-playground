resource "google_container_cluster" "cluster1" {
  project                  = var.service_project_name
  name                     = "cluster1"
  location                 = var.region
  remove_default_node_pool = true
  initial_node_count       = 1

  workload_identity_config {
    workload_pool = "${var.service_project_name}.svc.id.goog"
  }

  node_config {
    disk_size_gb = 10
    machine_type = "e2-standard-2"
    tags = ["gke-primary"]
  }

  deletion_protection = false
}

resource "google_container_node_pool" "cluster1_primary" {
  project    = var.service_project_name
  name       = "primary"
  location   = var.region
  cluster    = google_container_cluster.cluster1.name
  node_count = 1

  node_config {
    disk_size_gb = 10
    preemptible  = false
    machine_type = "e2-standard-2"

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

resource "google_gke_hub_membership" "membership" {
  project       = var.service_project_name
  membership_id = "${var.service_project_name}-membership"
  endpoint {
    gke_cluster {
      resource_link = google_container_cluster.cluster1.id
    }
  }
  depends_on = [google_container_node_pool.cluster1_primary]
}

resource "google_gke_hub_feature" "asm" {
  project    = var.service_project_name
  name       = "servicemesh"
  location   = "global"
  depends_on = [google_gke_hub_membership.membership]
}

resource "google_gke_hub_feature_membership" "feature_member" {
  project    = var.service_project_name
  location   = "global"
  feature    = google_gke_hub_feature.asm.name
  membership = google_gke_hub_membership.membership.membership_id
  mesh {
    management = "MANAGEMENT_AUTOMATIC"
  }
  depends_on = [google_gke_hub_feature.asm]
}
