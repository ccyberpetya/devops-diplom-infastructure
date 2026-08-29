resource "yandex_vpc_network" "main" {
  name = var.network_name
}
resource "yandex_vpc_subnet" "main" {
  for_each = var.subnets

  name           = "devops-dip-subnet-${each.key}"
  zone           = each.value.zone
  network_id     = yandex_vpc_network.main.id
  v4_cidr_blocks = [each.value.cidr]
}