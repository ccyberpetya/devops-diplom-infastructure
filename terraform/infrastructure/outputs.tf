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