module "vpc" {

        source = "./modules/vpc"

        project                 = var.project
        network                 = var.network

}

module "subnetwork" {

        source = "./modules/subnetwork"

        project                 = var.project
        network                 = module.vpc.network
        subnetwork              = var.subnetwork
        CIDR                    = var.CIDR
        region                  = var.region

}

module "firewall" {

        source = "./modules/firewall"

        project                 = var.project
        network                 = module.vpc.network
	firewall		= var.firewall

}

module "vm" {

        source = "./modules/vm"

        project                 = var.project
        network                 = module.subnetwork.network
        subnetwork              = module.subnetwork.subnetwork
        zone                    = var.zone
	vmname			= var.vmname
	vmcount			= var.vmcount

}

module "private_ip" {

        source = "./modules/private_ip_address"
	
	project                 = var.project
        networkid               = module.vpc.id
	privateipname		= var.privateipname

}

module "private_vpc" {

	source = "./modules/private_vpc_connection"

	networkid		= module.vpc.id
	privateipaddressname	= module.private_ip.private_ip_name
	privatevpcname		= var.privatevpcname

}

module "sqldbinstance" {

	source = "./modules/sql_database_instance"

	project                 = var.project
	region                  = var.region
	private_vpc		= module.private_vpc
	networkid		= module.vpc.id
	sqlinstancename		= var.sqlinstancename
}

module "Databases" {

	source = "./modules/Databases"

	project                 = var.project
	sqlinstancename		= module.sqldbinstance.sqldbinstancename

}

module "sqluser" {

	source = "./modules/sqluser"

	project                 = var.project
        sqlinstancename         = module.sqldbinstance.sqldbinstancename

}

