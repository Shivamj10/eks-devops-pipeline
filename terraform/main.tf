provider "aws" {
  region = "us-east-1"
}

module "vpc" {
  source              = "./vpc"
  vpc_cidr            = "10.0.0.0/16"
  public_subnet_cidrs = ["10.0.1.0/24", "10.0.2.0/24"]
  private_subnet_cidrs = ["10.0.101.0/24", "10.0.102.0/24"]
  azs                 = ["us-east-1a", "us-east-1b"]
  project_name        = "eks-pipeline"
}

module "subnet" {
  source = "./subnet"

  vpc_id            = module.vpc.vpc_id
  public_subnets    = ["10.0.1.0/24", "10.0.2.0/24"]
  private_subnets   = ["10.0.3.0/24", "10.0.4.0/24"]
  availability_zones = ["us-east-1a", "us-east-1b"]
}

module "igw" {
  source = "./igw"

  vpc_id = module.vpc.vpc_id
}

module "route_tables" {
  source             = "./terraform/route-tables"
  vpc_id             = module.vpc.vpc_id
  igw_id             = module.igw.igw_id
  public_subnet_ids  = module.subnet.public_subnet_ids
  project_name       = var.project_name
}

