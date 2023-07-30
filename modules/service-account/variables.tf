variable "policy_path" {
  type = string
}

variable "condition_values" {
  type = list(string)
}

variable "policy_name" {
  type = string
}

variable "role_name" {
  type = string
}

variable "service_account" {
  type = object({
    name = string
    namespace = string
  })
}

variable "cluster_name" {
  type = string
}

variable "oidc_arn" {
  type = list(string)
}