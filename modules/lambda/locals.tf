locals {
  aws_account_id     = var.aws_account_id
  application_name   = "fiap-fastfood"
  lab_role_arn       = "arn:aws:iam::${local.aws_account_id}:role/LabRole"
}