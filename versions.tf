terraform {
  required_providers {
    external = {
      version = "~> 2.3.0"
    }
    local = {
      version = ">= 2.4.0"
    }
    yandex = {
      source = "yandex-cloud/yandex"
    }
  }

  required_version = "~> 1.10.0"
}
