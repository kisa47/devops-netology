terraform {
  required_providers {
    yandex = {
      source = "yandex-cloud/yandex"
    }
  }
  required_version = ">= 0.13"
  
  backend "s3" {
    endpoint   = "storage.yandexcloud.net"
    bucket     = "terraform-surtsov"
    region     = "ru-central1"
    key        = "07-terraform-03-basic.tfstate"
    access_key = "YCAJELJWzDAAgPRYTO8QxRLwA"
    secret_key = "xxx"

    skip_region_validation      = true
    skip_credentials_validation = true
  }
}