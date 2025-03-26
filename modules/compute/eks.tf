terraform {
  required_providers {
    helm = {
      source  = "hashicorp/helm"
      version = ">= 2.0.0"
    }
  }
}

resource "aws_eks_cluster" "fiap_fastfood" {
  name     = local.application_name
  role_arn = var.node_role_arn

  vpc_config {
    subnet_ids = local.subnet_ids
  }

  version = local.kubernetes_version
}

resource "aws_eks_node_group" "default_ng1" {
  cluster_name    = aws_eks_cluster.fiap_fastfood.name
  node_group_name = "default-ng1"
  node_role_arn   = var.node_role_arn
  subnet_ids      = var.subnet_ids

  scaling_config {
    desired_size = 2
    min_size     = 1
    max_size     = 3
  }

  instance_types = [local.instance_type]
  capacity_type  = "ON_DEMAND"
}
