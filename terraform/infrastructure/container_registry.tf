resource "yandex_container_registry" "app" {
  name      = "devops-dip-registry"
  folder_id = var.folder_id

  labels = {
    project = "devops-diploma"
  }
}

resource "yandex_container_repository" "app" {
  name = "${yandex_container_registry.app.id}/devops-dip-app"
}