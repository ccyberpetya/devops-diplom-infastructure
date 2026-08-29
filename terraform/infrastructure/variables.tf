variable "cloud_id" {
  description = "Yandex Cloud ID"
  type        = string
}

variable "folder_id" {
  description = "Yandex Cloud Folder ID"
  type        = string
}

variable "network_name" {
  description = "Name of the VPC network"
  type        = string
  default     = "devops-dip-network"
}
variable "subnets" {
  description = "VPC subnets for Kubernetes nodes"

  type = map(object({
    zone = string
    cidr = string
  }))

  default = {
    a = {
      zone = "ru-central1-a"
      cidr = "10.10.1.0/24"
    }

    b = {
      zone = "ru-central1-b"
      cidr = "10.10.2.0/24"
    }

    d = {
      zone = "ru-central1-d"
      cidr = "10.10.3.0/24"
    }
  }
}