locals {
    application_name = "fiap-fastfood"
    db_name = "${local.application_name}-db"
    db_engine_version = "17.4"
    db_instance = "db.t3.micro"
    db_subnet_group_name = "fiap-fastfood-db-subnet-group"
    subnet_ids = var.subnet_ids
    availability_zone = "us-east-1a"
    db_user = "postgres"
    db_password = var.db_password
}