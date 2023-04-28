resource "google_compute_firewall" "rules" {
  project     = var.project
  name        = var.firewall
  network     = var.network
  description = "Creates firewall rule targeting tagged instances"

  allow {
    protocol  = "tcp"
    ports     = ["22", "80", "443"]
  }

  source_ranges = ["0.0.0.0/0"]

  target_tags = ["web-server"]
}
