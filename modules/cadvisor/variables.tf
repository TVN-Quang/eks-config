variable "cluster_name" {
  type        = string
  description = "EKS cluster name."
}

variable "enable_cadvisor" {
  type        = bool
  description = "Set to true for enable cadvisor or false for disable it."
}

variable "cadvisor_name" {
  type        = string
  description = "Load-balancer service name."
}

variable "cadvisor_chart_name" {
  type        = string
  description = "Ingress Gateway Helm chart name."
}

variable "cadvisor_template_path" {
  type        = string
  description = "template path"
}