provider "yandex" {
  cloud_id  = "b1g30el4lpanknnj4ka7"
  folder_id = "b1gl3hk9rf99el0n8ofd"
  zone      = "ru-central1-b"
}

data "yandex_compute_image" "ubuntu2004" {
    image_id = "fd8qs44945ddtla09hnr" 
}

resource "yandex_vpc_network" "net" {
    name = "net72"
}

resource "yandex_vpc_subnet" "subnet" {
    name            = "subnet72"
    network_id      = resource.yandex_vpc_network.net.id
    v4_cidr_blocks  = ["10.0.0.0/24"]
    zone            = "ru-central1-b"
}

resource "yandex_compute_instance" "netology" {
  name          = "test"
  hostname      = "netology-test"
  zone          = "ru-central1-b"
  platform_id   = "standard-v1"

  resources {
    cores         = 2
    memory        = 2
    core_fraction = 100
  }

  boot_disk {
    initialize_params {
      image_id  = data.yandex_compute_image.ubuntu2004.id
      type      = "network-hdd"
      size      = "10"
    }
  }

  network_interface {
    subnet_id   = yandex_vpc_subnet.subnet.id
    nat         = "true"
  }

  metadata = {
    ssh-keys = "ubuntu:${file("~/.ssh/id_rsa.pub")}"
  }
}