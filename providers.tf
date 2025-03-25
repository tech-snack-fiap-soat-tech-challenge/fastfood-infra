data "aws_eks_cluster" "fiap_fastfood" {
  name       = module.compute.cluster_name
  depends_on = [module.compute]
}

data "aws_eks_cluster_auth" "fiap_fastfood" {
  name       = module.compute.cluster_name
  depends_on = [module.compute]
}



provider "helm" {
  alias = "eks"
  kubernetes {
    host                   = data.aws_eks_cluster.fiap_fastfood.endpoint
    cluster_ca_certificate = base64decode(data.aws_eks_cluster.fiap_fastfood.certificate_authority[0].data)
    token                  = data.aws_eks_cluster_auth.fiap_fastfood.token
  }
}
