terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region = var.aws_region
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
  redirect_uri = local.auth_redirect_uri
}

module "lambda" {
  source                = "./modules/lambda"
  lab_role_arn          = local.lab_role_arn
  cognito_client_id     = module.cognito.user_pool_client_id
  gateway_execution_arn = module.gateway.integration_execution_arn
}

module "gateway" {
  source            = "./modules/gateway"
  backend_api_url   = var.api_host_name
  lambda_invoke_arn = module.lambda.integration_invoke_arn
  auth_provider_arn = module.cognito.user_pool_arn
}
