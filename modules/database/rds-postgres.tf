resource "aws_db_instance" "postgres" {
  identifier           = local.db_name
  engine_version       = local.db_engine_version
  engine               = "postgres"
  instance_class       = local.db_instance
  username             = local.db_user
  password             = local.db_password
  allocated_storage    = 20
  publicly_accessible  = true
  skip_final_snapshot  = true
  parameter_group_name = "default.postgres17"
  db_subnet_group_name = aws_db_subnet_group.default.name
}

resource "aws_db_subnet_group" "default" {
  name       = "fiap-fastfood-db-subnet-group"
  subnet_ids = local.subnet_ids
}

resource "aws_security_group" "rds_sg" {
  name        = "rds-security-group"
  description = "Allow inbound PostgreSQL traffic"

  ingress {
    from_port   = 5432
    to_port     = 5432
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
