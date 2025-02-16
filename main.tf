terraform {
  required_providers {
    yandex = {
      source = "yandex-cloud/yandex"
    }
  }
  required_version = ">= 0.13"
}

provider "yandex" {
  zone = "ru-central1-d"
}

resource "yandex_vpc_network" "example_network" {
  name = "otus-network"
}

resource "yandex_vpc_subnet" "example_subnet" {
  name = "otus-subnet"
  zone = var.zone
  network_id = yandex_vpc_network.example_network.id
  v4_cidr_blocks = ["10.0.0.0/24"]
}


resource "yandex_compute_instance" "example" {
  name = "vm-otus"
  platform_id = "standard-v3"
  resources {
    cores = 2
    memory = 2
  }
  boot_disk {
    initialize_params {
      image_id = data.yandex_compute_image.image.id
      size = var.vm_disk_size
    }
  }

network_interface {
    subnet_id = yandex_vpc_subnet.example_subnet.id
    nat = true
  }

    metadata = {


    user-data = "${file("meta/metadata.txt")}"
    }
}

data "yandex_compute_image" "image" {
  family = var.vm_image_family
 }

output "internal_ip_address_example" {
  value = yandex_compute_instance.example.network_interface.0.ip_address
}
