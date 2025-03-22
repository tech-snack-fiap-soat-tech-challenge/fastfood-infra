resource "aws_lambda_function" "authorizer" {
  filename         = "lambda-code/lambda.zip"
  function_name    = "AuthorizerLambda"
  role             = local.lab_role_arn
  handler          = "index.handler"
  runtime          = "nodejs20.x"
  source_code_hash = filebase64sha256("./lambda-code/lambda.zip")
}

output "lambda_arn" {
  value = aws_lambda_function.authorizer.arn
}
