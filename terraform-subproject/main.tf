terraform {
  backend "s3" {
    bucket                      = "devopstrain-learning-sanchpet-bucket"
    key                         = "terraform/yandex-cloud-vpc/state"  # обратите внимание, тут изменился ключ
    # Это старый вариант для версии ниже 1.6.0
    # endpoint                    = "https://storage.yandexcloud.net"
    region                      = "ru-central1"
    skip_region_validation      = true
    skip_credentials_validation = true
    # Начиная с версии 1.6.0 такой конфиг
    endpoints = { s3 = "https://storage.yandexcloud.net" }
    skip_requesting_account_id = true
    skip_s3_checksum = true
  }
}

terraform {
  required_providers {
    yandex = {
      source = "yandex-cloud/yandex"
    }
  }

  required_version = ">= 1.1.6"
}

provider "yandex" {}

resource "yandex_vpc_network" "main" {
  name = "main"
}

resource "yandex_vpc_subnet" "subnet-a" {
  zone           = "ru-central1-a"
  network_id     = "${yandex_vpc_network.main.id}"
  v4_cidr_blocks = ["10.5.0.0/24"]
}

output "subnet-id" {
  description = "Return subnet ID"
  value       = yandex_vpc_subnet.subnet-a.id
}
