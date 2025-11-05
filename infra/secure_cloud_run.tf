locals {
  cloudrun_key_name     = "cloud-run"
  cloudrun_keyring_name = "cloud-run-keyring"
}

module "secure_cloud_run" {
  source  = "GoogleCloudPlatform/cloud-run/google//modules/secure-cloud-run"
  version = "~> 0.16"

  connector_name              = "con-run"
  subnet_name                 = "vpc-subnet"
  vpc_project_id              = var.vpc_project_id
  serverless_project_id       = var.serverless_project_id
  kms_project_id              = var.kms_project_id
  shared_vpc_name             = var.shared_vpc_name
  ip_cidr_range               = var.ip_cidr_range
  key_name                    = local.cloudrun_key_name
  keyring_name                = local.cloudrun_keyring_name
  prevent_destroy             = false
  key_rotation_period         = "2592000s"
  service_name                = var.cloud_run_service_name
  location                    = var.region
  region                      = var.region
  image                       = var.image
  cloud_run_sa                = var.cloud_run_sa
  policy_for                  = var.policy_for
  folder_id                   = var.folder_id
  organization_id             = var.organization_id
  resource_names_suffix       = var.resource_names_suffix
  create_subnet               = false
  create_cloud_armor_policies = var.create_cloud_armor_policies
  cloud_armor_policies_name   = var.cloud_armor_policies_name
  groups                      = var.groups



 ssl_certificates = {
    generate_certificates_for_domains = var.domain
    ssl_certificates_self_links       = []
  }
}

resource "google_cloud_run_service_iam_member" "public_invoker" {
  project  = var.serverless_project_id
  location = var.region
  service  = module.secure_cloud_run.service_name
  role     = "roles/run.invoker"
  member   = "allUsers"
}