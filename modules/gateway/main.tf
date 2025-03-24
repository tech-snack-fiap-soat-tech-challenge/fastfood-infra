resource "aws_api_gateway_rest_api" "rest_api_gateway" {
  name        = "fastfood-auth-rest-api"
  description = "REST API Gateway for Fast-food Auth Lambda"
}

resource "aws_api_gateway_authorizer" "rest_api_gateway_authorizer" {
  name            = "fastfood-cognito-authorizer"
  type            = "COGNITO_USER_POOLS"
  identity_source = "method.request.header.Authorization"
  rest_api_id     = aws_api_gateway_rest_api.rest_api_gateway.id
  provider_arns = [var.auth_provider_arn]
}

# Resources and routes config for sign-in
resource "aws_api_gateway_resource" "auth_resource" {
  rest_api_id = aws_api_gateway_rest_api.rest_api_gateway.id
  parent_id   = aws_api_gateway_rest_api.rest_api_gateway.root_resource_id
  path_part   = "auth"
}

resource "aws_api_gateway_resource" "auth_sign_in_resource" {
  rest_api_id = aws_api_gateway_rest_api.rest_api_gateway.id
  parent_id   = aws_api_gateway_resource.auth_resource.id
  path_part   = "sign-in"
}

resource "aws_api_gateway_method" "auth_sign_in_endpoint" {
  rest_api_id   = aws_api_gateway_rest_api.rest_api_gateway.id
  resource_id   = aws_api_gateway_resource.auth_sign_in_resource.id
  http_method   = "POST"
  authorization = "NONE"
}

## Integration with lambda function for sign-in
resource "aws_api_gateway_integration" "auth_sign_in_integration" {
  rest_api_id             = aws_api_gateway_rest_api.rest_api_gateway.id
  resource_id             = aws_api_gateway_resource.auth_sign_in_resource.id
  http_method             = aws_api_gateway_method.auth_sign_in_endpoint.http_method
  integration_http_method = "POST"
  type                    = "AWS_PROXY"
  uri                     = var.lambda_invoke_arn
}

# Resources and routes config for place-order ###
resource "aws_api_gateway_resource" "order_resource" {
  rest_api_id = aws_api_gateway_rest_api.rest_api_gateway.id
  parent_id   = aws_api_gateway_rest_api.rest_api_gateway.root_resource_id
  path_part   = "orders"
}

resource "aws_api_gateway_method" "place_order_signed_endpoint" {
  rest_api_id   = aws_api_gateway_rest_api.rest_api_gateway.id
  resource_id   = aws_api_gateway_resource.order_resource.id
  http_method   = "POST"
  authorization = "COGNITO_USER_POOLS"
  authorizer_id = aws_api_gateway_authorizer.rest_api_gateway_authorizer.id
}

resource "aws_api_gateway_method" "place_order_unsigned_endpoint" {
  rest_api_id   = aws_api_gateway_rest_api.rest_api_gateway.id
  resource_id   = aws_api_gateway_resource.order_resource.id
  http_method   = "ANY"
  authorization = "NONE"
}

## Integration with rest application on EKS cluster for place order
resource "aws_api_gateway_integration" "place_order_signed_integration" {
  rest_api_id             = aws_api_gateway_rest_api.rest_api_gateway.id
  resource_id             = aws_api_gateway_resource.order_resource.id
  http_method             = aws_api_gateway_method.place_order_signed_endpoint.http_method
  integration_http_method = "POST"
  type                    = "HTTP_PROXY"
  uri                     = "${var.backend_api_url}/orders"
}

resource "aws_api_gateway_integration" "place_order_unsigned_integration" {
  rest_api_id             = aws_api_gateway_rest_api.rest_api_gateway.id
  resource_id             = aws_api_gateway_resource.order_resource.id
  http_method             = aws_api_gateway_method.place_order_unsigned_endpoint.http_method
  integration_http_method = "POST"
  type                    = "HTTP_PROXY"
  uri                     = "${var.backend_api_url}/orders"
}

# Deployment configs
resource "aws_api_gateway_deployment" "rest_api_gateway_deployment" {
  rest_api_id = aws_api_gateway_rest_api.rest_api_gateway.id

  depends_on = [
    aws_api_gateway_integration.auth_sign_in_integration,
    aws_api_gateway_integration.place_order_signed_integration,
    aws_api_gateway_integration.place_order_unsigned_integration
  ]
}

resource "aws_api_gateway_stage" "rest_api_gateway_stage" {
  rest_api_id   = aws_api_gateway_rest_api.rest_api_gateway.id
  deployment_id = aws_api_gateway_deployment.rest_api_gateway_deployment.id
  stage_name    = "dev"
}
