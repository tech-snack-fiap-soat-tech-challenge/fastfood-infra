output "integration_invoke_arn" {
  description = "The invoke ARN of the Lambda function"
  value       = aws_lambda_function.auth_lambda.invoke_arn
}