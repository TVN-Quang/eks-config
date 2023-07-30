resource "kubernetes_resource_quota" "this" {
  for_each = { for rq in var.resource_quotas : rq.name => rq }
  metadata {
    name      = "${each.value.name}-quota"
    namespace = each.value.namespace
  }
  spec {
    hard = {
      "pods"            = each.value.pods
      "requests.cpu"    = each.value.cpu_requests
      "requests.memory" = each.value.memory_requests
      "limits.cpu"      = each.value.cpu_limits
      "limits.memory"   = each.value.memory_limits
    }
    scopes = each.value.scopes
  }
}