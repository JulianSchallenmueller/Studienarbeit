provider "google" {
  credentials = file("/home/julian/Documents/gcp/active-woodland-324808-271662d37497.json")

  project = "active-woodland-324808"
  region  = "europe-west3"
  zone    = "europe-west3-b"
}