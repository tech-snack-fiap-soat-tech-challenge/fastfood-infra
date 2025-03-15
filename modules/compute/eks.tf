provider "aws" {
  region = "us-east-1"
}

# Creating the EKS cluster using existing IAM Role
resource "aws_eks_cluster" "fiap_fastfood" {
  name     = "fiap-fastfood"
  role_arn = var.node_role_arn  # Now using a predefined IAM Role

  vpc_config {
    subnet_ids = var.subnet_ids  # Using pre-existing subnets
  }

  version = local.kubernetes_version
}

# Creating the Node Group for the EKS cluster
resource "aws_eks_node_group" "default_ng1" {
  cluster_name    = aws_eks_cluster.fiap_fastfood.name
  node_group_name = "default-ng1"
  node_role_arn   = var.node_role_arn
  subnet_ids      = var.subnet_ids  # Using pre-existing subnets

  scaling_config {
    desired_size = 2
    min_size     = 1
    max_size     = 3
  }

  instance_types = [local.instance_type]
  capacity_type  = "ON_DEMAND"
}
