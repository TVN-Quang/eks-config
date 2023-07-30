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

resource "kubernetes_namespace" "cloudwatch" {
  metadata {
    name = "cloudwatch"
  }
}

resource "helm_release" "fluent_bit" {
  count = var.enable_fluent_bit ? 1 : 0
  depends_on = [
    kubernetes_namespace.cloudwatch
  ]
  name       = "fluent-bit"
  repository = "https://aws.github.io/eks-charts"
  chart      = "aws-for-fluent-bit"
  namespace  = "cloudwatch"
  values = [
    file("${path.root}/templates/${var.fluent_bit_template_path}")
  ]
}

resource "helm_release" "cloudwatch_agent" {
  count = var.enable_cloudwatch_agent ? 1 : 0

  name       = "cloudwatch-agent"
  repository = "https://aws.github.io/eks-charts"
  chart      = "aws-cloudwatch-metrics"
  namespace  = "cloudwatch"
  values = [
    templatefile("${path.root}/templates/${var.cloudwatch_agent_template_path}",
      {
        clustername = var.cluster_name
    })
  ]
}
