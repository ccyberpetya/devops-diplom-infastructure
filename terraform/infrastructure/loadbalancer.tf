resource "yandex_lb_target_group" "k8s_workers" {
  name      = "devops-dip-k8s-workers"
  region_id = "ru-central1"

  target {
    subnet_id = yandex_vpc_subnet.main["b"].id
    address   = yandex_compute_instance.k8s["worker-1"].network_interface[0].ip_address
  }

  target {
    subnet_id = yandex_vpc_subnet.main["d"].id
    address   = yandex_compute_instance.k8s["worker-2"].network_interface[0].ip_address
  }
}

resource "yandex_lb_network_load_balancer" "k8s" {
  name = "devops-dip-k8s-nlb"

  listener {
    name        = "http"
    port        = 80
    target_port = 30080
    protocol    = "tcp"

    external_address_spec {
      ip_version = "ipv4"
    }
  }

  attached_target_group {
    target_group_id = yandex_lb_target_group.k8s_workers.id

    healthcheck {
      name = "traefik-http"

      tcp_options {
        port = 30080
      }
    }
  }
}