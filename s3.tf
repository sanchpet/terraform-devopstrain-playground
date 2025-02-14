// Создадим сервисный аккаунт
resource "yandex_iam_service_account" "sa" {
  name      = "tf-test-sa"
  folder_id = var.folder_id
}

// Выдадим доступ для сервисного аккаунта
resource "yandex_resourcemanager_folder_iam_member" "sa-editor" {
  role      = "storage.admin"
  member    = "serviceAccount:${yandex_iam_service_account.sa.id}"
  folder_id = var.folder_id
}

// Создадим ключи доступа
resource "yandex_iam_service_account_static_access_key" "sa-static-key" {
  service_account_id = yandex_iam_service_account.sa.id
  description        = "static access key for object storage"
}

// Создадим сам bucket
resource "yandex_storage_bucket" "bucket" {
  access_key =  yandex_iam_service_account_static_access_key.sa-static-key.access_key
  secret_key =  yandex_iam_service_account_static_access_key.sa-static-key.secret_key

  bucket = "devopstrain-learning-sanchpet-bucket" // Измените это имя слегка, т.к. оно должно быть уникальным
  acl    = "private"

  versioning {
    enabled = true
  }
}

// И добавим файл в бакет на основе ранее созданных ресурсов
resource "yandex_storage_object" "output" {
  access_key = yandex_iam_service_account_static_access_key.sa-static-key.access_key
  secret_key = yandex_iam_service_account_static_access_key.sa-static-key.secret_key
  // Обратите внимание как мы обращаемся к другим ресурсам - через точку
  bucket = yandex_storage_bucket.bucket.id //У ресурса yandex_storage_bucket есть атрибут .id 
  key    = "output.txt"
  content = local_file.example.content
}

resource "yandex_storage_bucket" "bucket-2" {
  access_key = yandex_iam_service_account_static_access_key.sa-static-key.access_key
  secret_key = yandex_iam_service_account_static_access_key.sa-static-key.secret_key

  bucket = "devopstrain-learning-sanchpet-bucket-2"
  acl    = "private"

  versioning {
    enabled = false
  }
}
