variable "project_id" {
  description = "project_id"
}

variable "region" {
  description = "region"
}

provider "google" {
  project = var.project_id
  region = var.region
}

resource "google_compute_network" "jsa_k8s_vpc" {
  name = "${var.project_id}-jsa-k8s-vpc"
  auto_create_subnetworks = false
}

resource "google_compute_subnetwork" "jsa_k8s_subnet" {
  name = "${var.project_id}-jsa-k8s-subnet"
  region = var.region
  network = google_compute_network.jsa_k8s_vpc.name
  ip_cidr_range = "10.10.0.0/24"
}