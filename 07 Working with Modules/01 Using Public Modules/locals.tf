locals {
  project_name = "Working-with-Modules"

  common_tags = {
    Project   = local.project_name
    Owner     = "Ali Khalil"
    ManagedBy = "Terraform"
  }
}
