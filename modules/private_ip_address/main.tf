resource "google_compute_global_address" "private_ip_address" {

  name          = "private-ip-address"
  project       = var.project
  purpose       = "VPC_PEERING"
  address_type  = "INTERNAL"
  prefix_length = 16
  network       = var.networkid
}
