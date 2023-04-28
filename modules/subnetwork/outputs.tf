output "network" {
	value = google_compute_subnetwork.test_subnetwork.network
}
output "subnetwork" {
	value = google_compute_subnetwork.test_subnetwork.name
}
