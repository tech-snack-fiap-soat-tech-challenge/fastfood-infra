resource "aws_lambda_function" "auth_lambda" {
  function_name    = "fastfood-auth-lambda"
  role             = var.lab_role_arn
  handler          = "src/functions/authenticate.handler"
  runtime          = "nodejs22.x"
  filename         = "${path.module}/files/lambda_package.zip"
  source_code_hash = filebase64sha256("${path.module}/files/lambda_package.zip")

  environment {
    variables = {
      COGNITO_CLIENT_ID = var.cognito_client_id
    }
  }
}

resource "aws_lambda_permission" "lambda_permission" {
  statement_id  = "AllowExecutionFromAPIGateway"
  action        = "lambda:InvokeFunction"
  principal     = "apigateway.amazonaws.com"
  function_name = aws_lambda_function.auth_lambda.function_name
  source_arn    = "${var.gateway_execution_arn}/*/*"
}
