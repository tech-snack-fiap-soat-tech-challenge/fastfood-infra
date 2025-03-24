locals {
  application_name  = "fiap-fastfood"
  lab_role_arn      = "arn:aws:iam::${var.aws_account_id}:role/LabRole"
  auth_redirect_uri = "https://${local.application_name}.com/callback"
}
