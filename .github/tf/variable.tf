variable "github_actions" {
  type    = string
  default = "false"
}

locals {
  github_actions = var.github_actions == "true"
}
