variable "lab_role_arn" {
  description = "Role utilizada na lambda"
  type        = string
}

variable "cognito_client_id" {
  description = "Client ID do Cognito"
  type        = string
}

variable "gateway_execution_arn" {
  description = "Execution ARN of the REST API Gateway"
  type        = string
}