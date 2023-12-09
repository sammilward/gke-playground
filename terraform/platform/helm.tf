provider "helm" {
  kubernetes {
    host                   = "https://${google_container_cluster.cluster1.endpoint}"
    cluster_ca_certificate = base64decode(google_container_cluster.cluster1.master_auth.0.cluster_ca_certificate)
    token                  = data.google_client_config.provider.access_token
  }
}

resource "helm_release" "istio_ingress_gateway" {
  name       = "ingress"
  namespace  = "istio-system"
  repository = "https://istio-release.storage.googleapis.com/charts"
  chart      = "istio-ingressgateway"
  depends_on = [ time_sleep.asm_wait ]
}
