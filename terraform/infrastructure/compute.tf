data "yandex_compute_image" "ubuntu" {
  family = "ubuntu-2404-lts"
}

resource "yandex_compute_instance" "k8s" {
  for_each = var.k8s_nodes

  name     = each.value.hostname
  hostname = each.value.hostname
  zone     = var.subnets[each.value.subnet].zone

  platform_id               = "standard-v3"
  allow_stopping_for_update = true

  resources {
    cores         = each.value.cores
    memory        = each.value.memory
    core_fraction = 20
  }

  scheduling_policy {
    preemptible = each.value.preemptible
  }

  boot_disk {
    initialize_params {
      image_id = data.yandex_compute_image.ubuntu.id
      type     = "network-hdd"
      size     = each.value.disk_size
    }
  }

  network_interface {
    subnet_id = yandex_vpc_subnet.main[each.value.subnet].id
    nat       = true

    security_group_ids = [
      each.value.role == "control-plane"
      ? yandex_vpc_security_group.control_plane.id
      : yandex_vpc_security_group.worker.id
    ]
  }

  metadata = {
    ssh-keys = "${var.ssh_user}:${file(pathexpand(var.ssh_public_key_path))}"
  }
}