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
variable "admin_cidr" {
  description = "Public IP address allowed for SSH and Kubernetes API access"
  type        = string
}


variable "k8s_nodes" {
  description = "Kubernetes cluster nodes"

  type = map(object({
    hostname    = string
    subnet      = string
    cores       = number
    memory      = number
    disk_size   = number
    preemptible = bool
    role        = string
  }))

  default = {
    control-plane = {
      hostname    = "k8s-control-plane"
      subnet      = "a"
      cores       = 2
      memory      = 4
      disk_size   = 20
      preemptible = false
      role        = "control-plane"
    }

    worker-1 = {
      hostname    = "k8s-worker-1"
      subnet      = "b"
      cores       = 2
      memory      = 4
      disk_size   = 20
      preemptible = true
      role        = "worker"
    }

    worker-2 = {
      hostname    = "k8s-worker-2"
      subnet      = "d"
      cores       = 2
      memory      = 4
      disk_size   = 20
      preemptible = true
      role        = "worker"
    }
  }
}



variable "ssh_public_key_path" {
  description = "Path to SSH public key"
  type        = string
  default     = "~/.ssh/id_ed25519.pub"
}

variable "ssh_user" {
  description = "SSH user for Kubernetes nodes"
  type        = string
  default     = "ubuntu"
}