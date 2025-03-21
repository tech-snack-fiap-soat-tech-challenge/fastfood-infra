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

# Modules
module "database" {
  source      = "./modules/database"
  subnet_ids  = var.subnet_ids
  db_password = var.db_password
}

# module "compute" {
#   source     = "./modules/compute"
#   subnet_ids = var.subnet_ids
#   aws_account_id = var.aws_account_id
# }
