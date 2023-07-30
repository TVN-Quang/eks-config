variable "cert_manager_version" {
  type        = string
  description = "The version of the cert-manager Helm chart to install"
  default     = "1.6.1"
}

variable "cert_manager_namespace" {
  type        = string
  description = "The namespace to install the cert-manager Helm release into"
  default     = "kube-system"
}

variable "cert_manager_chart_repository" {
  type        = string
  description = "The repository URL for the cert-manager Helm chart"
  default     = "https://charts.jetstack.io"
}

variable "cert_manager_chart_name" {
  type        = string
  description = "The name of the cert-manager Helm chart to install"
  default     = "cert-manager"
}

variable "cert_manager_install_crds" {
  type        = bool
  description = "Whether to install CRDs for cert-manager"
  default     = true
}
