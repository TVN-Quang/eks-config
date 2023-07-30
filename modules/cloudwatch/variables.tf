variable "cluster_name" {
  type        = string
  description = "EKS cluster name."
}

variable "enable_fluent_bit" {
  type        = bool
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
  type        = string
  description = "This's path of cloudwatch agent helm values."
}