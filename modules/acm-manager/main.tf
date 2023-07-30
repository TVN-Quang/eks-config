resource "helm_release" "cert_manager" {
  name       = var.cert_manager_chart_name
  repository = var.cert_manager_chart_repository
  chart      = var.cert_manager_chart_name
  version    = var.cert_manager_version
  namespace  = var.cert_manager_namespace

  set {
    name  = "installCRDs"
    value = var.cert_manager_install_crds
  }
}