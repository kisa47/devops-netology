output "zone" {
    value       = yandex_compute_instance.netology.zone
    description = "Зона, которая используется в данный момент"
}

output "ip" {
    value       = yandex_compute_instance.netology.network_interface.0.ip_address
    description = "Приватный IP ya инстансы"
}

output "subnet" {
    value       = yandex_vpc_subnet.subnet.id
    description = "Идентификатор подсети в которой создан инстанс"
}