# File: role/main.tf
resource "kubernetes_role_v1" "this" {
  metadata {
    name      = var.metadata.name
    namespace = var.metadata.namespace
  }

  dynamic "rule" {
    for_each = var.rules
    content {
      api_groups = rule.value.api_groups
      resources  = rule.value.resources
      verbs      = rule.value.verbs
    }
  }
}
