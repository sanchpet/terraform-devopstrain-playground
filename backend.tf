terraform {
  backend "s3" {
    bucket = "devopstrain-learning-sanchpet-bucket"
    key    = "terraform/yandex-cloud/state"
    # Это старый вариант для версии ниже 1.6.0
    # endpoint                    = "https://storage.yandexcloud.net"
    region                      = "ru-central1"
    skip_region_validation      = true
    skip_credentials_validation = true
    # Начиная с версии 1.6.0 такой конфиг
    endpoints                  = { s3 = "https://storage.yandexcloud.net" }
    skip_requesting_account_id = true
    skip_s3_checksum           = true
  }
}

data "terraform_remote_state" "networking" {
  backend = "s3"
  config = {
    bucket = "devopstrain-learning-sanchpet-bucket"
    key    = "terraform/yandex-cloud-vpc/state" # используем данные из VPC-проекта
    # Это старый вариант для версии ниже 1.6.0
    # endpoint                    = "https://storage.yandexcloud.net"
    region = "ru-central1"
    # Начиная с версии 1.6.0 такой конфиг
    endpoints                   = { s3 = "https://storage.yandexcloud.net" }
    skip_requesting_account_id  = true
    skip_s3_checksum            = true
    skip_region_validation      = true
    skip_credentials_validation = true
  }
}
