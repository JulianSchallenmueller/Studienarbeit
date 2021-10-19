variable "region" {
  default = "europe-west3"
}

variable "zone" {
  default = "europe-west3-b"
}

variable "credentials" {
  description = "gcp project key"
  type        = string
  sensitive   = true
}

variable "project" {
  description = "project-id"
  type        = string
  sensitive   = false
}