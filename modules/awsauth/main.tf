module "role" {
  source = "../role"

  metadata = var.role_metadata

  rules = var.rules
}

module "rolebinding" {
  source = "../rolebinding"

  role_binding_namespace = module.role.namespace
  role_binding_name      = var.role_binding_name
  role_ref_name          = module.role.name
  subject_name           = var.subject_name

}

# data "kubernetes_config_map_v1" "aws_auth" {
#   metadata {
#     name      = "aws-auth"
#     namespace = "kube-system"
#   }
# }

# locals {
#   map_users = concat(yamldecode(data.kubernetes_config_map_v1.aws_auth.data["mapUsers"]), var.additional_users)
#   map_roles = concat(yamldecode(data.kubernetes_config_map_v1.aws_auth.data["mapRoles"]), var.additional_roles)
# }

# resource "kubernetes_config_map_v1" "aws_auth" {
#   metadata {
#     name      = data.kubernetes_config_map_v1.aws_auth.metadata[0].name
#     namespace = data.kubernetes_config_map_v1.aws_auth.metadata[0].namespace
#   }

#   data = {
#     mapUsers = yamlencode(local.map_users)
#     mapRoles = yamlencode(local.map_roles)
#   }
# }

# resource "local_file" "aws_auth" {
#   filename = "aws-auth.yaml"
#   content = yamlencode({
#     apiVersion = "v1"
#     kind       = "ConfigMap"
#     metadata = {
#       name      = "aws-auth"
#       namespace = "kube-system"
#     }
#     data = {
#       mapUsers = yamlencode(local.map_users)
#       mapRoles = yamlencode(local.map_roles)
#     }
#   })
# }

resource "null_resource" "kubectl_apply" {
  triggers = {
    always_run = timestamp()
  }

  provisioner "local-exec" {
    command = "kubectl apply -f aws-auth.yaml"
  }
}