locals {
  aws_account_id     = var.aws_account_id
  application_name   = "fiap-fastfood"
  kubernetes_version = "1.32"
  instance_type      = "t3.micro"
  lab_role_arn       = "arn:aws:iam::${local.aws_account_id}:role/LabRole"

  subnet_ids = var.subnet_ids
}