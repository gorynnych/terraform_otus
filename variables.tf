variable "zone" {
  description = "Зона размещения виртуальной машины"
  default = "ru-central1-d"
}

variable "vm_image_family" {
  description = "Семейство образа виртуальной машины"
  default = "ubuntu-1804-lts"
}

variable "vm_disk_size" {
  description = "Размер диска виртуальной машины (ГБ)"
  default = 20
}
