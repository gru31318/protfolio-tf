module "vpc" {
  source = "./modules/vpc"

  prefix      = var.prefix
  anyone_cidr = var.anyone_cidr
  cidr_vpc    = var.cidr_vpc
  sub_count   = var.sub_count
}

module "cluster" {
  source     = "./modules/cluster"
  depends_on = [module.vpc]

  prefix          = var.prefix
  subnet_ids      = module.vpc.subnet_ids
  cluster_version = var.cluster_version
  ami_type        = var.ami_type
  disk_size       = var.disk_size
  instance_types  = var.instance_types
}

module "argocd" {
  source     = "./modules/argocd"
  depends_on = [module.vpc, module.cluster]
}