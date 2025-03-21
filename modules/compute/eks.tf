provider "aws" {
  region = "us-east-1"
}

resource "aws_eks_cluster" "fiap_fastfood" {
  name     = "fiap-fastfood"
  role_arn = local.lab_role_arn

  vpc_config {
    subnet_ids = local.subnet_ids
  }

  version = local.kubernetes_version
}

# Disabled this for faster deployment, this is necessary for the auto-scaler
# resource "aws_eks_addon" "metrics_server" {
#   cluster_name = aws_eks_cluster.fiap_fastfood.name
#   addon_name   = "metrics-server"
# }

resource "aws_eks_node_group" "default_ng1" {
  cluster_name    = aws_eks_cluster.fiap_fastfood.name
  node_group_name = "default-ng1"
  node_role_arn   = local.lab_role_arn
  subnet_ids      = aws_eks_cluster.fiap_fastfood.vpc_config[0].subnet_ids

  scaling_config {
    desired_size = 2
    min_size     = 2
    max_size     = 4
  }

  instance_types = [local.instance_type]
  capacity_type  = "ON_DEMAND"
}
