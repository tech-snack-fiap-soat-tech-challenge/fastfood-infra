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
  source           = "./modules/cognito"
  user_pool_domain = var.user_pool_domain
}

module "lambda" {
  source            = "./modules/lambda"
  lab_role_arn      = var.lab_role_arn
  cognito_client_id = module.cognito.user_pool_client_id
  aws_account_id    = var.aws_account_id
  api_gtw_arn_permission = module.api-gtw.execution_arn
}

module "api-gtw" {
  source              = "./modules/api-gtw"
  aws_region          = var.aws_region
  user_pool_domain    = var.user_pool_domain
  lambda_invoke_arn   = module.lambda.invoke_arn
  user_pool_id        = module.cognito.user_pool_id
  user_pool_client_id = module.cognito.user_pool_client_id
}