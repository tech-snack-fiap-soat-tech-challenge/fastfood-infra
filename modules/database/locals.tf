locals {
  application_name     = "fiap-fastfood"
  db_name              = "${local.application_name}-db"
  db_subnet_group_name = "${local.application_name}-db-subnet-group"
  db_engine_version    = "17.4"
  db_instance          = "db.t3.micro"
  subnet_ids           = var.subnet_ids
  availability_zone    = "us-east-1a"
  db_user              = var.db_user
  db_password          = var.db_password

  databases = toset([
    "checkout-${local.db_name}",
    "products-${local.db_name}",
    "customers-${local.db_name}"
  ])
}