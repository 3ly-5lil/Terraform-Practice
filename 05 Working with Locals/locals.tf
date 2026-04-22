locals {
  project       = "working-with-locals"
  project_owner = "Ali Khalil"
  cost_center   = "cloud-infrastructure"
  managed_by    = "terraform"

  common_tags = {
    Project    = local.project
    Owner      = local.project_owner
    CostCenter = local.cost_center
  }
}
