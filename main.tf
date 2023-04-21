variable "project" {}
variable "network" {}
variable "subnetwork" {}

resource "google_compute_network" "vpc_network" {
  project                 = var.project
  name                    = var.network
  auto_create_subnetworks = false
  mtu                     = 1460
}

resource "google_compute_subnetwork" "test_subnetwork" {
  project       = var.project
  name          = var.subnetwork
  network       = google_compute_network.vpc_network.name
  ip_cidr_range = "10.0.0.0/22"
  region        = "us-central1"
}

resource "google_compute_firewall" "rules" {
  project     = var.project
  name        = "tf-firewall-rule"
  network     = google_compute_network.vpc_network.name
  description = "Creates firewall rule targeting tagged instances"

  allow {
    protocol  = "tcp"
    ports     = ["22", "80", "443"]
  }

  source_ranges = ["0.0.0.0/0"]

  target_tags = ["web-server"]
}

resource "google_compute_instance" "default" {
  project      = var.project
  count        = 1
  name         = "tf-vm-${count.index}"
  machine_type = "e2-medium"
  zone         = "us-central1-a"

  tags = ["web-server"]

  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-11"
      labels = {
        my_label = "value"
      }
    }
  }

  network_interface {
    network = google_compute_network.vpc_network.name
    subnetwork = google_compute_subnetwork.test_subnetwork.name
    subnetwork_project = var.project
    access_config {
      // Ephemeral public IP
    }
  }
}

resource "google_sql_database_instance" "master" {
  name = "mysqlinstance"
  database_version = "MYSQL_8_0"
  region = "us-central1"
  settings {
    tier = "db-n1-standard-2"
  }
}

resource "google_sql_database" "database" {
  name = "mttestdatabase"
  instance = google_sql_database_instance.master.name
  charset = "utf8"
  collation = "utf8_general_ci"
}

resource "google_sql_user" "users" {
  name = "root"
  instance = google_sql_database_instance.master.name
  host = "%"
  password = "Chethan@12"
}
