output "integration_execution_arn" {
  description = "The execution ARN of the REST API Gateway"
  value       = aws_api_gateway_rest_api.rest_api.execution_arn
}

output "api_endpoint" {
  description = "The base URL of the REST API Gateway"
  value       = "https://${aws_api_gateway_rest_api.rest_api.id}.execute-api.${var.aws_region}.amazonaws.com/dev"
}
