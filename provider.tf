terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.65.0"
    }
    helm = {
      source  = "hashicorp/helm"
      version = "~> 2.10.1"
    }
    # kubernetes = {
    #   source = "hashicorp/kubernetes"
    #   version = "~> 2.21.1"
    # }
    kubectl = {
      source  = "gavinbunney/kubectl"
      version = "~> 1.14.0"
    }
  }
  required_version = ">= 1.3.0"

  backend "s3" {
    bucket = "nachman-adika-bucket"
    key    = "terraform.tfstate"
    region = "eu-west-2"
  }
}

provider "aws" {
  region = "eu-west-2"
  default_tags {
    tags = {
      bootcamp        = "18"
      Owner           = "Nachman_Adika"
      expiration_date = "01-07-23"
    }
  }
}

provider "helm" {
  kubernetes {
    config_path            = "~/.kube/config"
    host                   = module.cluster.cluster_endpoint
    token                  = module.cluster.cluster_token
    cluster_ca_certificate = module.cluster.cluster_ca_certificate
  }
}

provider "kubectl" {
  config_path            = "~/.kube/config"
  host                   = module.cluster.cluster_endpoint
  token                  = module.cluster.cluster_token
  cluster_ca_certificate = module.cluster.cluster_ca_certificate
}
