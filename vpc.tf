resource "yandex_vpc_network" "main" {
  name = "main"
}

resource "yandex_vpc_subnet" "subnet-a" {
  zone           = var.subnet_params.zone
  network_id     = "${yandex_vpc_network.main.id}"
  v4_cidr_blocks = var.subnet_params.cidr             # A new subnet
}
