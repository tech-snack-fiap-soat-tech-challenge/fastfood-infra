output "user_pool_client_id" {
  value = aws_cognito_user_pool_client.user_pool_client.id
}

output "user_pool_arn" {
  value = aws_cognito_user_pool.user_pool.arn
}
