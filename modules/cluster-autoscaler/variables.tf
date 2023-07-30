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
