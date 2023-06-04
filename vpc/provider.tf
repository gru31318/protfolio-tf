terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.65.0"
    }
  }
  required_version = ">= 1.3.0"

  # backend "s3" {
  #   bucket = "nachman-adika-bucket"
  #   key    = "terraform.tfstate"
  #   region = "eu-west-2"
  # }
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