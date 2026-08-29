output "terraform_sa_access_key" {
  description = "Access key for Terraform S3 backend"
  value       = yandex_iam_service_account_static_access_key.terraform_sa_static_key.access_key
  sensitive   = true
}

output "terraform_sa_secret_key" {
  description = "Secret key for Terraform S3 backend"
  value       = yandex_iam_service_account_static_access_key.terraform_sa_static_key.secret_key
  sensitive   = true
}

output "terraform_state_bucket" {
  description = "Terraform state bucket name"
  value       = yandex_storage_bucket.terraform_state.bucket
}