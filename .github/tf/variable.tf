variable "github_action" {
  type    = string
  default = "false"
}

locals {
  github_action = var.github_action == "true"
}
