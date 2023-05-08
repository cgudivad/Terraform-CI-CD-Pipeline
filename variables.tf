
variable "project" {
        default = "cg-project-374417"
}

variable "vpcnetworkname" {
	default = "dev-vpcnetwork"
}

variable "subnetworkname" {
        default = "dev-testsubnetwork"
}

variable "firewallname" {
        default = "dev-firewallrule"
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
        default = "us-central1-b"
}

variable "vmcount" {
	default = 2
}
