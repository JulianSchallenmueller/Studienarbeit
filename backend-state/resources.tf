resource "google_compute_network" "jsa_vpc_network" {
  name = "jsa-terraform-network"
}

resource "google_compute_instance" "jsa_vm_instance" {
  name         = "jsa-terraform-instance"
  machine_type = "f1-micro"
  tags         = ["example-tag"]

  boot_disk {
    initialize_params {
      image = "ubuntu-os-cloud/ubuntu-minimal-2004-lts"
    }
  }

  network_interface {
    network = google_compute_network.jsa_vpc_network.name
    access_config {
    }
  }
}

resource "google_compute_firewall" "jsa_vm_firewall" {
  name = "jsa-terraform-firewall"

  network = google_compute_network.jsa_vpc_network.name

  allow {
    protocol = "tcp"
    ports    = ["22"]
  }
}