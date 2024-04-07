module "roboshop_vpc" {
    #source = "../vpc-module"
    source = "git::https://github.com/aws-devops9/terraform-vpc-module.git?ref=master"
    # We are parsing the below variables as we rquire these variables for tagging 
    project_name = var.project_name
    environment = var.environment
    common_tags = var.common_tags
    vpc_tags = var.vpc_tags

    #public subnet
    public_subnets_cidr = var.public_subnets_cidr

    #private subnet
    private_subnets_cidr = var.private_subnets_cidr

    #database subnet
    database_subnets_cidr = var.database_subnets_cidr

    #vpc peering
    is_peering_required = var.is_peering_required
}