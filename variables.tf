variable "project" {
        default = "cg-project-374417"
}

variable "vpcnetworkname" {
	default = "dev-vpc-network"
}

variable "subnetworkname" {
        default = "dev-test-subnetwork"
}

variable "firewallname" {
        default = "dev-firewall-rule"
}

variable "vmname" {
        default = "dev-tf-vm-"
}

variable "privateipname" {
        default = "dev-private-ip"
}

variable "privatevpcname" {
        default = "dev-private-vpc"
}

variable "sqlinstancename" {
        default = "dev-sql-instance"
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
