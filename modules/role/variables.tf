# File: role/main.tf
variable "metadata" {
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
