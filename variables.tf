variable "network" {
	default = "dev-vpc-network"
}

variable "project" {
        default = "cg-project-374417"
}

variable "subnetwork" {
        default = "dev-test-subnetwork"
}

variable "CIDR" {
        default = "10.10.1.0/24"
}

variable "region" {
        default = "us-central1"
}

variable "zone" {
        default = "us-central1-a"
}

variable "vmcount" {
	default = 2
}

