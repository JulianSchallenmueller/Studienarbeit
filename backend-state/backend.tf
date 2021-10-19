terraform {
  backend "remote" {
    organization = "juscit06-study-org"

    workspaces {
      name = "terraform-playground-backend-gcp"
    }
  }
}