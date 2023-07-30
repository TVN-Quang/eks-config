variable "resource_quotas" {
  type = list(object({
    name            = string
    namespace       = string
    cpu_requests    = string
    memory_requests = string
    cpu_limits      = string
    memory_limits   = string
    pods            = number
    scopes          = list(string)
  }))
  description = "List of Kubernetes admins."
}
