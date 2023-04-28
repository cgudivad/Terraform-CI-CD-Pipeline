resource "google_service_networking_connection" "private_vpc_connection" {

  network                 = var.networkid
  service                 = "servicenetworking.googleapis.com"
  reserved_peering_ranges = [var.privateipaddressname]

}
