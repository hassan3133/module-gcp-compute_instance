#----------------------------------------------------------------------------
# computetest
#----------------------------------------------------------------------------

resource "google_service_account" "computetest" {
  account_id   = "pl-computetest"
  display_name = "pl-computetest"
}

module "computetest_compute_instance" {
  source = "../../modules/compute_instance"
  # module_count = 6

  cell         = "guse4-poc"
  clusterid    = "a"
  disk_size    = 32
  machine_type = "g1-small"
  servertype   = "computetest"
  subnet_type  = "private"
  # zones_limit  = 2

  # pass through
  env     = var.env
  project = var.project
  region  = var.region

  labels = {
    owner      = "common_svcs_dev_priceline_com"
    dns        = ""
    inventory  = ""
    ansible    = "done"
    managed_by = "terraform"
  }

  tags = [
    "infrastructure",
    "midtier-application"
  ]

}
