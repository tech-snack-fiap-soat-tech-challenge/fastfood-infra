resource "aws_apigatewayv2_api" "http_api" {
  name          = "fastfood-auth-http-api"
  protocol_type = "HTTP"
}

resource "aws_apigatewayv2_authorizer" "cognito_authorizer" {
  api_id           = aws_apigatewayv2_api.http_api.id
  authorizer_type  = "JWT"
  identity_sources = ["$request.header.Authorization"]
  name             = "fastfood-cognito-authorizer"
  jwt_configuration {
    audience = [var.user_pool_client_id]
    issuer   = "https://cognito-idp.${var.aws_region}.amazonaws.com/${var.user_pool_id}"
  }
}

resource "aws_apigatewayv2_integration" "lambda_integration" {
  api_id                 = aws_apigatewayv2_api.http_api.id
  integration_type       = "AWS_PROXY"
  integration_uri        = var.lambda_invoke_arn
  payload_format_version = "2.0"
}

resource "aws_apigatewayv2_route" "cpf_route" {
  api_id             = aws_apigatewayv2_api.http_api.id
  route_key          = "POST /auth/cpf"
  target             = "integrations/${aws_apigatewayv2_integration.lambda_integration.id}"
  authorizer_id      = aws_apigatewayv2_authorizer.cognito_authorizer.id
  authorization_type = "JWT"
}

resource "aws_apigatewayv2_stage" "default_stage" {
  api_id      = aws_apigatewayv2_api.http_api.id
  name        = "$default"
  auto_deploy = true
}

