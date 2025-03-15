locals {
    application_name = "fiap-fastfood"
    kubernetes_version = "1.28"
    instance_type = "t3.micro"
    # node_role_arn = "arn:aws:iam::467897245441:role/LabRole"
    subnet_ids = var.subnet_ids
}