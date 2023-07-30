data "aws_eks_cluster" "this" {
  name = var.cluster_name
}

data "aws_eks_cluster_auth" "this" {
  name = var.cluster_name
}

provider "kubernetes" {
  host                   = data.aws_eks_cluster.this.endpoint
  cluster_ca_certificate = base64decode(data.aws_eks_cluster.this.certificate_authority.0.data)
  token                  = data.aws_eks_cluster_auth.this.token
}

resource "helm_release" "metrics_server" {
  name       = var.metrics_server_chart_name
  chart      = var.metrics_server_release_name
  repository = var.metrics_server_chart_repo
  version    = var.metrics_server_version
  namespace  = var.metrics_server_namespace

#   values = [
#     yamlencode(var.settings)
#   ]

}

