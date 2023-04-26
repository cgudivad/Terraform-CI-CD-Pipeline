variable "project" {}
variable "network" {}
variable "subnetwork" {}
variable "region" {}
variable "zone" {}

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
  settings {
    tier = "db-n1-standard-2"
	ip_configuration {
	  dynamic "authorized_networks" {
        for_each = google_compute_instance.default
        iterator = default
        content {
          name  = default.value.name
          value = default.value.network_interface.0.access_config.0.nat_ip
        }
      }
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
