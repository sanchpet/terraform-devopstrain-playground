resource "yandex_vpc_network" "main" {
  name = "main"
}

resource "yandex_vpc_subnet" "subnet-a" {
  zone           = "ru-central1-a"
  network_id     = "${yandex_vpc_network.main.id}"
  v4_cidr_blocks = ["10.5.0.0/24"]                  # A new subnet
}
