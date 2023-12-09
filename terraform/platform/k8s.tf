data "google_client_config" "provider" {}

provider "kubernetes" {
  host                   = "https://${google_container_cluster.cluster1.endpoint}"
  cluster_ca_certificate = base64decode(google_container_cluster.cluster1.master_auth.0.cluster_ca_certificate)
  token                  = data.google_client_config.provider.access_token
}

resource "kubernetes_namespace" "sam" {
  metadata {
    name = "sam"
    labels = {
      "istio-injection" = "enabled"
    }
  }
  depends_on = [ google_container_node_pool.cluster1_primary ]
}

resource "kubernetes_deployment" "utility" {
  metadata {
    name      = "utility"
    namespace = kubernetes_namespace.sam.metadata.0.name
    labels = {
      "app" = "utility"
    }
  }
  spec {
    replicas = 1
    selector {
      match_labels = {
        "app" = "utility"
      }
    }
    template {
      metadata {
        labels = {
          "app" = "utility"
        }
      }
      spec {
        container {
          image = "europe-west2-docker.pkg.dev/sams-service-project/sams-docker-registry/ubuntu-debugger:latest"
          name  = "utility"
        }
      }
    }
  }
  depends_on = [kubernetes_namespace.sam, google_artifact_registry_repository_iam_member.member]
}
