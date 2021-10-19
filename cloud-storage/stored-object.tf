resource "google_storage_bucket_object" "hello" {
  name   = "hello"
  source = "./files/hello.txt"
  bucket = "jsa-terraform-bucket"

  depends_on = [
    google_storage_bucket.jsa_terraform_bucket
  ]
}