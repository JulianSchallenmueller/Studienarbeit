variable "image" {
  description = "Docker image to be deployed"
}

provider "kubernetes" {
  host     = google_container_cluster.jsa_primary.endpoint

  token = data.google_client_config.default.access_token
  cluster_ca_certificate = base64decode(google_container_cluster.jsa_primary.master_auth[0].cluster_ca_certificate)
}

data "google_client_config" "default" {}

resource "kubernetes_deployment" "jsa_testapp" {
  metadata {
    name = "jsa-testapp"
    labels = {
      App = "jsa-testapp"
    }
  }

  spec {
    replicas = 2
    selector {
      match_labels = {
        App = "jsa-testapp"
      }
    }

    template {
      metadata {
        labels = {
          App = "jsa-testapp"
        }
      }
      spec {
        container {
          image = var.image
          name = "jsa-testapp"

          port {
            container_port = 8080
          }
        }
      }
    }
  }
}

resource "kubernetes_service" "jsa_testapp_lb" {
  metadata {
    name =  "jsa-testapp-example"
  }

  spec {
    selector = {
      App = kubernetes_deployment.jsa_testapp.spec.0.template.0.metadata[0].labels.App
    }
    port {
      port = 8081
      target_port = 8080
    }

    type = "LoadBalancer"
  }
}