locals {
  application_name   = "fiap-fastfood"
  kubernetes_version = "1.32"
  instance_type      = "t3.micro"
  subnet_ids         = var.subnet_ids
}