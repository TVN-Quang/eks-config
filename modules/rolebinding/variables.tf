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
