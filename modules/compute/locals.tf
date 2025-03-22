locals {
  application_name   = "fiap-fastfood"
  kubernetes_version = "1.28"
  instance_type      = "t3.micro"
  subnet_ids         = var.subnet_ids
}