locals {
  cluster_subnet_cidrs = [
    for subnet in var.subnets : subnet.cidr
  ]
}


resource "yandex_vpc_security_group" "control_plane" {
  name        = "k8s-control-plane-sg"
  description = "Security group for Kubernetes control plane"
  network_id  = yandex_vpc_network.main.id

  ingress {
    description    = "Kubernetes internal cluster traffic"
    protocol       = "ANY"
    v4_cidr_blocks = local.cluster_subnet_cidrs
  }

  ingress {
    description    = "SSH access"
    protocol       = "TCP"
    port           = 22
    v4_cidr_blocks = [var.admin_cidr]
  }

  ingress {
    description    = "Kubernetes API"
    protocol       = "TCP"
    port           = 6443
    v4_cidr_blocks = [var.admin_cidr]
  }

  egress {
    description    = "Allow outbound traffic"
    protocol       = "ANY"
    v4_cidr_blocks = ["0.0.0.0/0"]
  }
}


resource "yandex_vpc_security_group" "worker" {
  name        = "k8s-worker-sg"
  description = "Security group for Kubernetes worker nodes"
  network_id  = yandex_vpc_network.main.id

  ingress {
    description    = "Kubernetes internal cluster traffic"
    protocol       = "ANY"
    v4_cidr_blocks = local.cluster_subnet_cidrs
  }

  ingress {
    description    = "SSH access for Kubespray"
    protocol       = "TCP"
    port           = 22
    v4_cidr_blocks = [var.admin_cidr]
  }

  egress {
    description    = "Allow outbound traffic"
    protocol       = "ANY"
    v4_cidr_blocks = ["0.0.0.0/0"]
  }
}