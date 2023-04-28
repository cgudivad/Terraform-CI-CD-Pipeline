variable "network" {
	default = "staging-vpc-network"
}

variable "project" {
        default = "cg-project-374417"
}

variable "subnetwork" {
        default = "staging-test-subnetwork"
}

variable "firewall" {
        default = "staging-firewall-rule"
}

variable "vmname" {
        default = "staging-tf-vm-"
}

variable "privateipname" {
        default = "staging-private-ip"
}

variable "privatevpcname" {
        default = "staging-private-vpc"
}

variable "sqlinstancename" {
        default = "staging-sql-instance"
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

