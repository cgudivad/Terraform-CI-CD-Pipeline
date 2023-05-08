module "network" {

        source = "git::https://github.com/cgudivad/Terraform-Modules.git//network?ref=tags/V0.0.2"

        project                 = var.project
        vpcnetworkname          = var.vpcnetworkname
	subnetworkname          = var.subnetworkname
        CIDR                    = var.CIDR
        region                  = var.region
	firewallname		= var.firewallname

}

module "vm" {

        source = "git::https://github.com/cgudivad/Terraform-Modules.git//vm?ref=tags/V0.0.2"

        project                 = var.project
        vpcnetworkname          = module.network.vpcnetworkname
        subnetworkname          = module.network.subnetworkname
        zone                    = var.zone
	vmname			= var.vmname
	vmcount			= var.vmcount

}

module "private_vpc" {

	source = "git::https://github.com/cgudivad/Terraform-Modules.git//private_vpc_connection?ref=tags/V0.0.2"

	project                 = var.project
	privateipname		= var.privateipname
	vpcnetworkid		= module.network.vpcnetworkid

}

module "sqldbinstance" {

	source = "git::https://github.com/cgudivad/Terraform-Modules.git//sql_database_instance?ref=tags/V0.0.2"

	project                 = var.project
	region                  = var.region
	private_vpc		= module.private_vpc
	vpcnetworkid		= module.network.vpcnetworkid
	sqlinstancename		= var.sqlinstancename
}
