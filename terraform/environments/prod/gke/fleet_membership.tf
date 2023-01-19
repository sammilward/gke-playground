module "fleet_membership" {
  source                    = "../../../shared/modules/fleet-membership"
  cluster_name              = var.cluster_name
  project_id                = var.project_id
  location                  = var.region
  enable_fleet_registration = true
  # Leaving this blank becomes <proj>-<region>-<cluster name> which is > max 63 chars
  membership_name = var.cluster_name
  #enable_mesh_auto_controlplane_management = true

  depends_on = [
    google_container_cluster.primary
  ]
}