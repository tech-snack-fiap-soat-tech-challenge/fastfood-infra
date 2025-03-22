variable "lab_role_arn" {
  description = "Role utilizada na lambda"
  type        = string
}

variable "cognito_client_id" {
  description = "Client ID do Cognito"
  type        = string
}

variable "aws_account_id" {
  description = "ID da conta AWS"
  type        = string
}

variable "api_gtw_arn_permission" {
  description = "ARN da permissão de invocação da lambda"
  type        = string
}