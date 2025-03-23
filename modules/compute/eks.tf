# Criação do cluster EKS
resource "aws_eks_cluster" "fiap_fastfood" {
  name     = "fiap-fastfood"
  role_arn = var.node_role_arn

  vpc_config {
    subnet_ids = local.subnet_ids
  }

  version = local.kubernetes_version
}

# Grupo de nodes do cluster
resource "aws_eks_node_group" "default_ng1" {
  cluster_name    = aws_eks_cluster.fiap_fastfood.name
  node_group_name = "default-ng1"
  node_role_arn   = var.node_role_arn
  subnet_ids      = local.subnet_ids

  scaling_config {
    desired_size = 2
    min_size     = 1
    max_size     = 3
  }

  instance_types = [local.instance_type]
  capacity_type  = "ON_DEMAND"
}

# Autenticação no cluster EKS
data "aws_eks_cluster_auth" "fiap_fastfood" {
  name = aws_eks_cluster.fiap_fastfood.name
}

# Provider do Helm apontando para o cluster EKS
provider "helm" {
  kubernetes {
    host                   = aws_eks_cluster.fiap_fastfood.endpoint
    cluster_ca_certificate = base64decode(aws_eks_cluster.fiap_fastfood.certificate_authority[0].data)
    token                  = data.aws_eks_cluster_auth.fiap_fastfood.token
  }
}

# Instalação do Metrics Server via Helm
resource "helm_release" "metrics_server" {
  name       = "metrics-server"
  repository = "https://kubernetes-sigs.github.io/metrics-server/"
  chart      = "metrics-server"
  namespace  = "kube-system"
  version    = "3.12.1"

  set {
    name  = "args[0]"
    value = "--kubelet-insecure-tls"
  }

  depends_on = [
    aws_eks_cluster.fiap_fastfood,
    aws_eks_node_group.default_ng1
  ]
}

