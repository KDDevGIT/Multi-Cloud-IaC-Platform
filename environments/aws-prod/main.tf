provider "aws" {
    region = var.aws_region
}

module "network" {
    source = "../../module/aws/network"
    name = var.name
    cidr_block = var.vpc_cidr
}

module "compute" {
  source = "../../module/aws/compute"
  name = var.name
  vpc_id = module.network.vpc_id
  public_subnets = module.network.public_subnet_ids
  private_subnets = module.network.private_subnet_ids
}

module "database" {
    source = "../../modules/aws/database"
    name = var.name
    vpc_id = module.network.vpc_id
    private_subnets = module.network.private_subnet_ids
    db_username = var.db_username
    db_password = var.db_password
}

//TESTING COMMIT CONFIG