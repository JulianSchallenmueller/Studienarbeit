resource "google_storage_bucket" "jsa_terraform_bucket" {
  name = "jsa-terraform-bucket"

  location = "EU"
  force_destroy = true

  uniform_bucket_level_access = true
}