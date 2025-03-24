output "api_gateway_url" {
  description = "The base URL of the REST API Gateway"
  value       = "https://${module.gateway.rest_api_gateway_id}.execute-api.${var.aws_region}.amazonaws.com/dev"
}
