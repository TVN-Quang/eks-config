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

data "local_file" "values" {
  filename = "${path.root}/templates/${var.nginx_template_path}"
}

resource "helm_release" "nginx_ingress" {
  name       = var.nginx_ingress_name
  chart      = var.nginx_ingress_chart_name
  repository = var.nginx_ingress_chart_repo
  version    = var.nginx_ingress_chart_version
  namespace  = "kube-system"

  values = [data.local_file.values.content]
}

# resource "kubernetes_ingress_v1" "this" {
#   for_each = { for ingress in var.ingress_list : ingress.name => ingress }

#   metadata {
#     name        = each.value.name
#     namespace   = each.value.namespace
#     annotations = each.value.annotations
#   }

#   spec {
#     ingress_class_name = each.value.ingress_class_name

#     dynamic "rule" {
#       for_each = each.value.ingress_rules
#       content {
#         host = rule.value.host
#         http {
#           dynamic "path" {
#             for_each = rule.value.paths
#             content {
#               path      = path.value.path
#               path_type = path.value.path_type
#               backend {
#                 service {
#                   name = path.value.service_name
#                   port {
#                     number = path.value.service_port
#                   }
#                 }
#               }
#             }
#           }
#         }
#       }
#     }
#   }
# }