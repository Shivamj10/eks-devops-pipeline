provider "aws" {
  region = "us-east-1"
}

module "vpc" {
  source               = "./vpc"
  vpc_cidr             = "10.0.0.0/16"
  public_subnet_cidrs  = ["10.0.11.0/24", "10.0.12.0/24"]
  private_subnet_cidrs = ["10.0.21.0/24", "10.0.22.0/24"]
  azs                  = ["us-east-1a", "us-east-1b"]
  project_name         = "eks-pipeline"
  igw_id               = module.igw.igw_id
}

module "subnet" {
  source = "./subnet"

  vpc_id             = module.vpc.vpc_id
  public_subnets     = ["10.0.11.0/24", "10.0.12.0/24"]
  private_subnets    = ["10.0.21.0/24", "10.0.22.0/24"]
  availability_zones = ["us-east-1a", "us-east-1b"]
}

module "igw" {
  source = "./igw"

  vpc_id = module.vpc.vpc_id
}

module "route_tables" {
  source            = "./route_tables"
  vpc_id            = module.vpc.vpc_id
  igw_id            = module.igw.igw_id
  public_subnet_ids = [module.subnet.public_subnet_ids[0]]

}

module "nat_gateway" {
  source = "./nat_gateway"

  vpc_id            = module.vpc.vpc_id
  public_subnet_ids = [module.subnet.public_subnet_ids[0]]
  allocation_id     = module.eip.allocation_id
}


module "eip" {
  source = "./eip"
}

module "eks" {
  source          = "./eks"
  cluster_name    = "shivam-eks-cluster"
  region          = var.region
  subnet_ids      = module.subnet.private_subnet_ids
  vpc_id          = module.vpc.vpc_id
  cluster_version = "1.29"
}


module "route_table_private" {
  source             = "./route_table_private"
  vpc_id             = module.vpc.vpc_id
  nat_gateway_id     = module.nat_gateway.nat_gateway_id
  private_subnet_ids = module.subnet.private_subnet_ids
}

