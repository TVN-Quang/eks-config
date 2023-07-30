# File: role/main.tf
variable "role_metadata" {
  type = object({
    name      = string
    namespace = string
  })
}

variable "rules" {
  type = list(object({
    api_groups = list(string)
    resources  = list(string)
    verbs      = list(string)
  }))
}

variable "role_binding_name" {
  type = string
  default = "my-role-binding"
  description = "The name of the role binding"
}

variable "role_binding_namespace" {
  type = string
  default = ""
  description = "The namespace in which the role binding will be created"
}

variable "role_ref_api_group" {
  type = string
  default = "rbac.authorization.k8s.io"
  description = "The API group of the Role that will be bound to the subject"
}

variable "role_ref_kind" {
  type = string
  default = "Role"
  description = "The kind of the Role that will be bound to the subject"
}

variable "role_ref_name" {
  type = string
  default = ""
  description = "The name of the Role that will be bound to the subject"
}

variable "subject_kind" {
  type = string
  default = "User"
  description = "The kind of the subject that will be bound to the Role"
}

variable "subject_name" {
  type = string
  default = "my-user"
  description = "The name of the subject that will be bound to the Role"
}

variable "subject_api_group" {
  type = string
  default = "rbac.authorization.k8s.io"
  description = "The API group of the subject that will be bound to the Role"
}

variable "additional_users" {
  type = list(object({
    userarn = string
    username = string
    groups = list(string)
  }))
  default = []
  description = "A list of additional users to add to the aws-auth config map"
}

variable "additional_roles" {
  type = list(object({
    rolearn = string
    username = string
    groups = list(string)
  }))
  default = []
  description = "A list of additional roles to add to the aws-auth config map"
}