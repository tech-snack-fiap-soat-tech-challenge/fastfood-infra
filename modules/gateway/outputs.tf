output "integration_execution_arn" {
  description = "The execution ARN of the REST API Gateway"
  value       = aws_api_gateway_rest_api.rest_api_gateway.execution_arn
}

output "rest_api_gateway_id" {
  description = "The ID of the REST API Gateway"
  value       = aws_api_gateway_rest_api.rest_api_gateway.id
}
