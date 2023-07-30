data "aws_caller_identity" "current" {} # used for accesing Account ID and ARN

data "aws_eks_cluster" "this" {
  name = var.cluster_name
}

# get EKS cluster info to configure Kubernetes and Helm providers
data "aws_iam_policy_document" "this" {
  statement {
    actions = ["sts:AssumeRoleWithWebIdentity"]
    effect  = "Allow"

    condition {
      test     = "StringEquals"
      variable = "${replace(data.aws_eks_cluster.this.identity[0].oidc[0].issuer, "https://", "")}:sub"
      values   = ["system:serviceaccount:${namespace}:test-ssm"]
    }

    condition {
      test     = "StringEquals"
      variable = "${replace(data.aws_eks_cluster.this.identity[0].oidc[0].issuer, "https://", "")}:aud"
      values   = ["sts.amazonaws.com"]
    }


    principals {
      identifiers = var.oidc_arn
      type        = "Federated"
    }
  }
}

resource "aws_iam_policy" "this" {
  name = var.policy_name
  policy = file("${path.root}/${var.policy_path}")
}

resource "aws_iam_role" "this" {
  assume_role_policy = data.aws_iam_policy_document.this.json
  name               = var.role_name
}

resource "aws_iam_role_policy_attachment" "role_policy_attach" {
  role       = aws_iam_role.this.name
  policy_arn = aws_iam_policy.this.arn
}

resource "kubernetes_service_account" "this" {
  metadata {
    name      = var.service_account.name
    namespace = var.service_account.namespace
    annotations = {
      "eks.amazonaws.com/role-arn" = "arn:aws:iam::${data.aws_caller_identity.current.account_id}:role/${aws_iam_role.this.name}"
    }
  }
}



