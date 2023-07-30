variable "cluster_name" {
  type        = string
  description = "EKS cluster name."
}

variable "metrics_server_chart_name" {
  type        = string
  default     = "metrics-server"
  description = "Metrics Server Helm chart name to be installed"
}

variable "metrics_server_release_name" {
  type        = string
  default     = "metrics-server"
  description = "Helm release name"
}

variable "metrics_server_version" {
  type        = string
  default     = "5.9.2"
  description = "Metrics Server Helm chart version."
}

variable "metrics_server_chart_repo" {
  type        = string
  default     = "https://kubernetes-sigs.github.io/metrics-server/"
  description = "Metrics Server repository name."
}

variable "create_namespace" {
  type        = bool
  default     = false
  description = "Whether to create Kubernetes namespace with name defined by `namespace`."
}

variable "metrics_server_namespace" {
  type        = string
  default     = "kube-system"
  description = "Kubernetes namespace to deploy Metrics Server Helm chart."
}
