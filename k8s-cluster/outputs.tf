output "region" {
  value = var.region
  description = "GCloud region"
}

output "zone" {
  value = var.zone
  description = "GCloud zone"
}

output "project_id" {
  value = var.project_id
  description = "GCloud project ID"
}

output "kubernetes_cluster_name" {
  value = google_container_cluster.jsa_primary.name
  description = "GKE cluster name"
}

output "kubernetes_cluster_host" {
  value = google_container_cluster.jsa_primary.endpoint
  description = "GKE cluster host"
}

output "lb_ip" {
  value = kubernetes_service.jsa_testapp_lb.status.0.load_balancer.0.ingress.0.ip
  description = "External loadbalancer ip"
}

output "link_to_app" {
  value = "http://${kubernetes_service.jsa_testapp_lb.status.0.load_balancer.0.ingress.0.ip}:${kubernetes_service.jsa_testapp_lb.spec[0].port[0].port}"
  description = "The deployed ap can be accessed under this address"
}