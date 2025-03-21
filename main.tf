terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region = "us-east-1"
}

## Modules
module "database" {
  source      = "./modules/database"
  subnet_ids  = var.subnet_ids
  db_password = var.db_password
}

module "compute" {
  source        = "./modules/compute"
  node_role_arn = var.lab_role_arn
  subnet_ids    = var.subnet_ids
}