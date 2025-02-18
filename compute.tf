data "yandex_compute_image" "ubuntu-2204-latest" {  # image for new machine
  family = "ubuntu-2204-lts"
}

resource "yandex_compute_disk" "secondary-disk-first-vm" { # Disk to save persistent data
  count = length(var.disks)
  name = var.disks[count.index]
  type     = "network-hdd"
  zone     = "ru-central1-a"
  size     = 20
  folder_id = var.folder_id
}

resource "yandex_compute_instance" "first-vm" {
  platform_id = "standard-v1"
  zone        = "ru-central1-a"
  count = length(var.instances)
  name = var.instances[count.index]
  folder_id = var.folder_id

  resources {                   # Machine params
    cores  = var.first_vm_compute_resources[count.index].cores
    core_fraction = var.first_vm_compute_resources[count.index].core_fraction
    memory = var.first_vm_compute_resources[count.index].memory
  }

  boot_disk {               # Image's ID to boot from
    initialize_params {
      image_id = "${data.yandex_compute_image.ubuntu-2204-latest.id}"
    }
  }

secondary_disk {            # Connect to save persistent data
    disk_id = "${yandex_compute_disk.secondary-disk-first-vm[count.index].id}"
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
