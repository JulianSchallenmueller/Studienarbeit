resource "google_compute_network" "jsa_vpc_network" {
  name = "jsa-terraform-network"
}

resource "google_compute_firewall" "jsa_vm_firewall" {
  name = "jsa-terraform-firewall"

  network = google_compute_network.jsa_vpc_network.name

  allow {
    protocol = "tcp"
    ports    = ["22"]
  }
}

resource "google_compute_instance" "jsa_vm_instance-gcli" {
  name = "jsa-terraform-vm-gcli"

  machine_type = "f1-micro"

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

  metadata_startup_script = "echo hello world > /hello.txt"
  metadata = {
    "enable-oslogin" = "FALSE"
  }
}

resource "google_compute_instance" "jsa_vm_instance_metadata" {
  name = "jsa-vm-instance-metadata"

  machine_type = "f1-micro"

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

  metadata = {
    "ssh-keys" = "julian:ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQDBoOcebUT6JXXbSfTe5AuZ88Jil6NA+j6piUJb3zlBA6aplYUKiOMa/N9m8MbD2R96ezmWO6QYrmxpLVYopUkS5tvm17gyxW4nyQiv0zlUn/qmdzJfIpTjkChdDsHDxO5Rz15dRebM7NgJBYFZJFAwVpl/eVtR35fvc78TJdBxFxe+ofc0GM7bwsgIpAHihk/xCASyTo0kAxWztLARdiVFs3ycbzTR+TSLFc1uhp5/AcXjp1MQkByNNLq6VxO26yhVFjN88c75grss3bGWM1+QUnDp9VKtt0XQ592ZEuqvfuCyBTaIcsqId3IjUQsiRqsQm13jx046qjnh9yKJUbSMWdTG5m06k8P3mb9MXHYHSFyuUVhHvB0rXf7OBzG3OQ4vNv+8vx3tv1FV7TjVHtrYqTdM5LhX2DSAPfnwQKEGAX7lAh/dsLQA4xgl5up26kQxuNy+5VFm1jRVn6/cUA6w8oBl7IQo7QtoE67DE71cHvUmujQ6qUrNHXn1OSYwL5s= julian"
  }

  metadata_startup_script = "echo hello world > /hello.txt"
}

resource "google_service_account" "jsa_service_account" {
  account_id = "jsa-sa"
}

resource "google_compute_instance" "jsa_vm_instance_sa" {
  name = "jsa-vm-instance-sa"

  machine_type = "f1-micro"

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

  metadata = {
    enable-oslogin = "TRUE"
  }

  metadata_startup_script = "echo hello world > /hello.txt"

  provisioner "local-exec" {
    command = "./local_scripts/iam-setup.sh"
  }
}