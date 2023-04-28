resource "google_compute_subnetwork" "test_subnetwork" {
  project       = var.project
  name          = var.subnetwork
  network       = var.network
  ip_cidr_range = var.CIDR
  region        = var.region
}
