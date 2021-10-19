variable "gke_username" {
  default     = "jsa"
  description = "gke username"
}

variable "gke_password" {
  default     = "testPass!4"
  description = "gke password"
}

variable "gke_num_nodes" {
  default     = 2
  description = "number of gke nodes"
}

variable "zone" {
  description = "GCloud zone"
}

resource "google_container_cluster" "jsa_primary" {
  name     = "${var.project_id}-jsa-gke"
  location = var.zone
 
  remove_default_node_pool = true
  initial_node_count       = 1

  network    = google_compute_network.jsa_k8s_vpc.name
  subnetwork = google_compute_subnetwork.jsa_k8s_subnet.name
}

resource "google_container_node_pool" "jsa_primary_nodes" {
  name       = "${google_container_cluster.jsa_primary.name}-node-pool"
  location   = var.zone
  cluster    = google_container_cluster.jsa_primary.name
  node_count = var.gke_num_nodes

  node_config {
    oauth_scopes = [
      "https://www.googleapis.com/auth/logging.write",
      "https://www.googleapis.com/auth/monitoring",
    ]

    labels = {
      env = var.project_id
    }

    machine_type = "e2-micro"
    tags         = ["jsa-gke-node", "${var.project_id}-jsa-gke"]
    metadata = {
      disable-legacy-endpoints = "true"
    }
  }
}