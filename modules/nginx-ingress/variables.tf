variable "cluster_name" {
  type        = string
  description = "EKS cluster name."
}

#*********** Nginx Ingress Controller ************
variable "nginx_ingress_name" {
  type        = string
  description = "Load-balancer service name."
}

variable "nginx_ingress_chart_name" {
  type        = string
  description = "Ingress Gateway Helm chart name."
}

variable "nginx_ingress_chart_repo" {
  type        = string
  description = "Ingress Gateway Helm repository name."
}

variable "nginx_ingress_chart_version" {
  type        = string
  description = "Ingress Gateway Helm chart version."
}

variable "nginx_template_path" {
  type        = string
  description = "template path"
}

# variable "ingress_list" {
#   type = list(object({
#     name      = string
#     namespace = string
#     annotations = map(string)
#     ingress_class_name = string
#     ingress_rules = list(object({
#       host = string
#       paths = list(object({
#         path         = string
#         path_type    = string
#         service_name = string
#         service_port = number
#       }))
#     }))
#   }))
# }