locals {
  application_name   = "fiap-fastfood"
  kubernetes_version = "1.32"
  instance_type      = "t3.micro"
  subnet_ids         = var.subnet_ids

  ecr_repositories = toset([
    "fastfood-order-service",
    "fastfood-product-service",
    "fastfood-customer-service",
    "fastfood-checkout-service"
  ])
}