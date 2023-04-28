resource "google_sql_database_instance" "master" {
  name = "mysqlinstance"
  database_version = "MYSQL_8_0"
  project      = var.project
  region = var.region
  deletion_protection = false
  depends_on = [var.private_vpc]

  settings {
    tier = "db-n1-standard-2"
    ip_configuration {

      ipv4_enabled                                  = false
      private_network                               = var.networkid
      enable_private_path_for_google_cloud_services = true

    }
  }
}
