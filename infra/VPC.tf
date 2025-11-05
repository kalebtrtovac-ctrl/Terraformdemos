resource "google_compute_network" "shared_vpc" {
  name                    = "shared-vpc"
  auto_create_subnetworks = false
  project                 = var.vpc_project_id
}

resource "google_compute_subnetwork" "shared_subnet" {
  name          = "vpc-subnet"
  ip_cidr_range = var.ip_cidr_range
  region        = var.region
  network       = google_compute_network.shared_vpc.self_link
  project       = var.vpc_project_id
}