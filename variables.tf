# EKS cluster define
variable "cluster_name" {
  type        = string
  description = "EKS cluster name."
}

variable "cluster_oidc_provider_arn" {
  type        = string
  description = "EKS Cluster OIDC Provider ARN"
}

variable "cluster_autoscaler_role_name" {
  type        = string
  description = "EKS cluster autoscaler role name"
}

variable "cluster_autoscaler_policy_name" {
  type        = string
  description = "EKS cluster autoscaler policy name"
}

variable "cluster_autoscaler_sa_name" {
  type        = string
  description = "EKS cluster autoscaler service account name"
}

variable "cluster_autoscaler_sa_namespace" {
  type        = string
  description = "EKS cluster autoscaler service account's namespace"
}

variable "cluster_autoscaler_policy_path" {
  type        = string
  description = "EKS cluster autoscaler policy"
}

# Ingress ALB
variable "ingress_gateway_name" {
  type        = string
  description = "Load-balancer service name."
}
variable "ingress_gateway_iam_role" {
  type        = string
  description = "IAM Role Name associated with load-balancer service."
}
variable "ingress_gateway_chart_name" {
  type        = string
  description = "Ingress Gateway Helm chart name."
}
variable "ingress_gateway_chart_repo" {
  type        = string
  description = "Ingress Gateway Helm repository name."
}
variable "ingress_gateway_chart_version" {
  type        = string
  description = "Ingress Gateway Helm chart version."
}

#***************** Horizontal autoscaler *****************

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

#***************** EBS_CSI_DRIVER *****************
variable "ebs_csi_driver_role_name" {
  type        = string
  description = "EKS EBS CSI Driver role name"
}

variable "ebs_csi_driver_policy_name" {
  type        = string
  description = "EKS EBS CSI Driver policy name"
}

variable "ebs_csi_driver_sa_name" {
  type        = string
  description = "EKS EBS CSI Driver service account name"
}

variable "ebs_csi_driver_sa_namespace" {
  type        = string
  description = "EKS EBS CSI Driver service account's namespace"
}

variable "ebs_csi_driver_policy_path" {
  type        = string
  description = "EKS EBS CSI Driver policy"
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

variable "nginx_template_path" {
  type        = string
  description = "template path"
}

#*********** Resource Quota **************
# variable "resource_quotas" {
#   type = list(object({
#     name            = string
#     namespace       = string
#     cpu_requests    = string
#     memory_requests = string
#     cpu_limits      = string
#     memory_limits   = string
#     pods            = number
#     scopes          = list(string)
#   }))
#   description = "List of Kubernetes admins."
# }

#*********** Service Account ***************
variable "service_accounts" {
  type = list(object({
    policy_path      = string
    condition_values = list(string)
    policy_name      = string
    role_name        = string
    service_account = object({
      name      = string
      namespace = string
    })
    cluster_name = string
    oidc_arn     = list(string)
  }))

  description = "List of kubernetes service accounts used in main.tf"
}

#*********** Cloudwatch ***************
variable "enable_fluent_bit" {
  type = bool
  description = "Set to true for enable fluent bit or false for disable it."
}

variable "fluent_bit_template_path" {
  type        = string
  description = "template path"
}

variable "enable_cloudwatch_agent" {
  type        = bool
  description = "Set to true for enable cloudwatch agent or false for disable it."
}

variable "cloudwatch_agent_template_path" {
  type = string
  description= "This's path of cloudwatch agent helm values."
}

#**** Cadvisor ***********
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

#***AWS AUTH***
variable "aws_auths" {
  type = list(object({
    role_metadata = object({
      name      = string
      namespace = string
    })
    rules = list(object({
      api_groups = list(string)
      resources  = list(string)
      verbs      = list(string)
    }))
    role_binding_name      = string
    
    subject_name           = string

    additional_users       = list(object({
      userarn  = string
      username = string
      groups   = list(string)
    }))

    additional_roles       = list(object({
      rolearn  = string
      username = string
      groups   = list(string)
    }))
  }))
}
