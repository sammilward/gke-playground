module "asm" {
  source           = "../../../shared/modules/asm"
  cluster_name     = "gke-playground-374709-gke"
  project_id       = var.project_id
  cluster_location = var.region
  # enable_fleet_registration = true
  enable_mesh_feature = true
  enable_cni          = true
}

# output "gateway_ip" {
#   value = local.istio_gateway_ip
# }
