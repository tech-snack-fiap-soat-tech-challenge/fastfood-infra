provider "aws" {
  region = "us-east-1"
}

resource "aws_eks_cluster" "fiap_fastfood" {
  name     = "fiap-fastfood"
  role_arn = local.node_role_arn

  vpc_config {
    subnet_ids = local.subnet_ids
  }

  version = local.kubernetes_version
}

resource "aws_eks_addon" "metrics_server" {
  cluster_name = aws_eks_cluster.fiap_fastfood.name
  addon_name   = "metrics-server"
}

resource "aws_eks_node_group" "default_ng1" {
  cluster_name    = aws_eks_cluster.fiap_fastfood.name
  node_group_name = "default-ng1"
  node_role_arn   = local.node_role_arn
  subnet_ids      = aws_eks_cluster.fiap_fastfood.vpc_config[0].subnet_ids

  scaling_config {
    desired_size = 4
    min_size     = 2
    max_size     = 4
  }

  instance_types = [local.instance_type]
  capacity_type  = "ON_DEMAND"
}

# resource "aws_db_instance" "postgres" {
#   identifier           = "fiap-fastfood-db"
#   engine              = "postgres"
#   engine_version      = "14.7"
#   instance_class      = "db.t3.micro"
#   allocated_storage   = 20
#   storage_type        = "gp2"
#   username           = "admin"
#   password           = "mypassword"
#   publicly_accessible = false
#   skip_final_snapshot = true
#   parameter_group_name = "default.postgres14"
#   db_subnet_group_name = aws_db_subnet_group.default.name
# }

# resource "aws_db_subnet_group" "default" {
#   name       = "fiap-fastfood-db-subnet-group"
#   subnet_ids = [
#     "subnet-09075664d7c5e9479",
#     "subnet-00c18aa8f293f396f",
#     "subnet-013fb5c5be441889e",
#     "subnet-08c77efc01a75cf5a"
#   ]
# }

# resource "aws_security_group" "rds_sg" {
#   name        = "rds-security-group"
#   description = "Allow inbound PostgreSQL traffic"

#   ingress {
#     from_port   = 5432
#     to_port     = 5432
#     protocol    = "tcp"
#     cidr_blocks = ["0.0.0.0/0"]
#   }
# }
