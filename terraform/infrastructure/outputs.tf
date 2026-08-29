output "k8s_internal_ips" {
  description = "Internal IP addresses of Kubernetes nodes"

  value = {
    for name, instance in yandex_compute_instance.k8s :
    name => instance.network_interface[0].ip_address
  }
}

output "k8s_external_ips" {
  description = "External IP addresses of Kubernetes nodes"

  value = {
    for name, instance in yandex_compute_instance.k8s :
    name => instance.network_interface[0].nat_ip_address
  }
}

output "nlb_public_ip" {
  description = "Public IP address of Kubernetes Network Load Balancer"

  value = one([
    for listener in yandex_lb_network_load_balancer.k8s.listener :
    one(listener.external_address_spec).address
  ])
}

output "container_registry_id" {
  description = "Yandex Container Registry ID"
  value       = yandex_container_registry.app.id
}

output "container_repository" {
  description = "Application container repository"
  value       = yandex_container_repository.app.name
}