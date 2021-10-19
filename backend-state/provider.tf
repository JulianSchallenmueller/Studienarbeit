terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "3.82.0"
    }
  }
}

provider "google" {
  credentials = var.credentials

  project = var.project
  region  = var.region
  zone    = var.zone
}