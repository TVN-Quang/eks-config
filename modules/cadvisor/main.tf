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

resource "helm_release" "cadvisor" {
  count = var.enable_cadvisor ? 1 : 0
  name       = var.cadvisor_name
  chart      = "${path.root}/charts/${var.cadvisor_chart_name}"
  namespace  = "kube-system"

  values = [
    file("${path.root}/templates/${var.cadvisor_template_path}")
  ]
}