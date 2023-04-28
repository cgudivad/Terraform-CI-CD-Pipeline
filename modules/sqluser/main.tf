resource "google_sql_user" "users" {
  name = "root"
  project      = var.project
  instance = var.sqlinstancename
  host = "%"
  password = "Chethan@12"
}
