variable "user_pool_domain" {
  description = "Cognito User Pool Domain prefix (subdomain)"
  type        = string
}

variable "user_pool_id" {
  description = "Cognito User Pool ID"
  type        = string
}

variable "user_pool_client_id" {
  description = "Cognito User Pool Client ID"
  type        = string
}

variable "aws_region" {
  description = "AWS region"
  type        = string
}

variable "lambda_invoke_arn" {
    description = "ARN da lambda"
    type        = string
}