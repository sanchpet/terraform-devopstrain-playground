data "yandex_compute_image" "ubuntu-2204-latest" {  # image for new machine
  family = "ubuntu-2204-lts"
}

resource "yandex_compute_disk" "secondary-disk-first-vm" { # Disk to save persistent data
  name     = "disk-name"
  type     = "network-hdd"
  zone     = "ru-central1-a"
  size     = 20 
}

resource "yandex_compute_instance" "first-vm" {
  name        = "first-vm"
  platform_id = "standard-v1"
  zone        = "ru-central1-a"

  resources {                   # Machine params
    cores  = 2
    core_fraction = 20
    memory = 2
  }

  boot_disk {               # Image's ID to boot from
    initialize_params {
      image_id = "${data.yandex_compute_image.ubuntu-2204-latest.id}"
    }
  }

secondary_disk {            # Connect to save persistent data
    disk_id = "${yandex_compute_disk.secondary-disk-first-vm.id}"
  }

  network_interface {                   # Network we created
    subnet_id = "${yandex_vpc_subnet.subnet-a.id}"
  }

  metadata = {  # public ssh key
    foo      = "bar"
    ssh-keys = "ubuntu:${file("~/.ssh/id_ed25519.pub")}"
  }

  allow_stopping_for_update = true  # explicilty alow turning off VM to updates

  depends_on = [        # explicitly set dependency from resource, so VM will not be created if disk not created
    yandex_compute_disk.secondary-disk-first-vm,
  ]
}
