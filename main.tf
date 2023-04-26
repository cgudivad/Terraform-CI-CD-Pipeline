variable "project" {}
variable "network" {}
variable "subnetwork" {}
variable "region" {}
variable "zone" {}
variable "CIDR" {}

resource "google_compute_network" "vpc_network" {
  project                 = var.project
  name                    = var.network
  mtu                     = 1460
  auto_create_subnetworks                   = false
}

resource "google_compute_global_address" "private_ip_address" {

  name          = "private-ip-address"
  project       = var.project
  purpose       = "VPC_PEERING"
  address_type  = "INTERNAL"
  prefix_length = 16
  network       = google_compute_network.vpc_network.id
}

resource "google_service_networking_connection" "private_vpc_connection" {

  network                 = google_compute_network.vpc_network.id
  service                 = "servicenetworking.googleapis.com"
  reserved_peering_ranges = [google_compute_global_address.private_ip_address.name]
}

resource "google_compute_subnetwork" "test_subnetwork" {
  project       = var.project
  name          = var.subnetwork
  network       = google_compute_network.vpc_network.name
  ip_cidr_range = var.CIDR
  region        = var.region
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
  count        = 2
  name         = "tf-vm-${count.index}"
  machine_type = "e2-medium"
  zone         = var.zone

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

  metadata = {
    startup-script = file("script.sh")
  }
}

resource "google_sql_database_instance" "master" {
  name = "mysqlinstance"
  database_version = "MYSQL_8_0"
  project      = var.project
  region = var.region
  deletion_protection = false
  depends_on = [google_service_networking_connection.private_vpc_connection]

  settings {
    tier = "db-n1-standard-2"
    ip_configuration {
		
      ipv4_enabled                                  = false
      private_network                               = google_compute_network.vpc_network.id
      enable_private_path_for_google_cloud_services = true

    }
  }
}

resource "google_sql_database" "database" {
  name = "mytestdatabase"
  project      = var.project
  instance = google_sql_database_instance.master.name
  charset = "utf8"
  collation = "utf8_general_ci"
}

resource "google_sql_user" "users" {
  name = "root"
  project      = var.project
  instance = google_sql_database_instance.master.name
  host = "%"
  password = "Chethan@12"
}
