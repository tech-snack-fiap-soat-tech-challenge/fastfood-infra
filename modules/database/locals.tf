locals {
    db_name = "fiap-fastfood-db"
    db_engine_version = "17.4"
    db_instance = "db.t3.micro"
    db_subnet_group_name = "fiap-fastfood-db-subnet-group"
    subnet_ids = var.subnet_ids

    db_user = "postgres"
    db_password = var.db_password
}