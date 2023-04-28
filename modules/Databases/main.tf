resource "google_sql_database" "database" {
  name = "mytestdatabase"
  project      = var.project
  instance = var.sqlinstancename
  charset = "utf8"
  collation = "utf8_general_ci"
}
