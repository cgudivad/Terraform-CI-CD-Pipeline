variable "project" {
        default = "cg-project-374417"
}

variable "vpcnetworkname" {
	default = "prod-vpc-network"
}

variable "subnetworkname" {
        default = "prod-test-subnetwork"
}

variable "firewallname" {
        default = "prod-firewall-rule"
}

variable "vmname" {
        default = "prod-tf-vm-"
}

variable "privateipname" {
        default = "prod-private-ip"
}

variable "privatevpcname" {
        default = "prod-private-vpc"
}

variable "sqlinstancename" {
        default = "prod-sql-instance"
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
