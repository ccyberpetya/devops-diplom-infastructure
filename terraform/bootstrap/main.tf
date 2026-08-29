resource "yandex_iam_service_account" "terraform_sa" {
  name        = "terraform-sa"
  description = "Service account for Terraform"
  folder_id   = var.folder_id
}

resource "yandex_resourcemanager_folder_iam_member" "terraform_sa_storage_editor" {
  folder_id = var.folder_id
  role      = "storage.editor"
  member    = "serviceAccount:${yandex_iam_service_account.terraform_sa.id}"
}

resource "yandex_resourcemanager_folder_iam_member" "terraform_sa_vpc_admin" {
  folder_id = var.folder_id
  role      = "vpc.admin"
  member    = "serviceAccount:${yandex_iam_service_account.terraform_sa.id}"
}

resource "yandex_resourcemanager_folder_iam_member" "terraform_sa_compute_editor" {
  folder_id = var.folder_id
  role      = "compute.editor"
  member    = "serviceAccount:${yandex_iam_service_account.terraform_sa.id}"
}

resource "yandex_resourcemanager_folder_iam_member" "terraform_sa_load_balancer_admin" {
  folder_id = var.folder_id
  role      = "load-balancer.admin"
  member    = "serviceAccount:${yandex_iam_service_account.terraform_sa.id}"
}

resource "yandex_iam_service_account_static_access_key" "terraform_sa_static_key" {
  service_account_id = yandex_iam_service_account.terraform_sa.id
  description        = "Static access key for Terraform S3 backend"
}

resource "yandex_storage_bucket" "terraform_state" {
  bucket    = "devops-dip-tfstate-${var.folder_id}"
  folder_id = var.folder_id

  force_destroy = false

  anonymous_access_flags {
    read        = false
    list        = false
    config_read = false
  }

  versioning {
    enabled = true
  }
}

resource "yandex_resourcemanager_folder_iam_member" "terraform_sa_container_registry_editor" {
  folder_id = var.folder_id
  role      = "container-registry.editor"
  member    = "serviceAccount:${yandex_iam_service_account.terraform_sa.id}"
}