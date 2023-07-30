resource "kubernetes_role_binding_v1" "this" {
  metadata {
    name      = var.role_binding_name
    namespace = var.role_binding_namespace
  }

  role_ref {
    api_group = var.role_ref_api_group
    kind      = var.role_ref_kind
    name      = var.role_ref_name
  }

  subject {
    kind      = var.subject_kind
    name      = var.subject_name
    namespace = var.role_binding_namespace
    api_group = var.subject_api_group
  }
}
