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
  node_role_arn = local.lab_role_arn
  subnet_ids    = var.subnet_ids
}

module "cognito" {
  source       = "./modules/cognito"
  redirect_uri = "https://fiap-fastfood.com.br/callback"
}

module "lambda" {
  source            = "./modules/lambda"
  lab_role_arn      = var.lab_role_arn
  cognito_client_id = module.cognito.user_pool_client_id
  aws_account_id    = var.aws_account_id
}
