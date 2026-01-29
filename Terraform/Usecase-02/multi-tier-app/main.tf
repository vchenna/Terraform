provider "aws" {
  region = var.region
}

module "networking" {
  source              = "./modules/networking"
  vpc_cidr            = "10.0.0.0/16"
  public_subnet_cidr  = "10.0.1.0/24"
  private_subnet_cidr = "10.0.2.0/24"
  az                  = "us-east-1a"
}

module "security" {
  source = "./modules/security"
  vpc_id = module.networking.vpc_id
}

module "compute" {
  source            = "./modules/compute"
  web_ami           = var.web_ami
  app_ami           = var.app_ami
  instance_type     = var.instance_type
  public_subnet_id  = module.networking.public_subnet_id
  private_subnet_id = module.networking.private_subnet_id
  web_sg_id         = module.security.web_sg_id
  app_sg_id         = module.security.app_sg_id
}

module "database" {
  source             = "./modules/database"
  private_subnet_ids = module.networking.private_subnet_ids
  db_username        = "admin"
  db_password        = "SuperSecurePass123"
  db_sg_id           = module.security.db_sg_id
}
