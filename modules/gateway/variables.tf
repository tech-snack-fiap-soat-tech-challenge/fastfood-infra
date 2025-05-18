variable "lambda_invoke_arn" {
  description = "ARN of lambda resource"
  type        = string
}

variable "auth_provider_arn" {
  description = "ARN of the Cognito User Pool"
  type        = string
}

variable "backend_api_url" {
  description = "Hostname of the backend API"
  type        = string
}
