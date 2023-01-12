#----------------------------------------------------------------------------
# computetest
#----------------------------------------------------------------------------

module "computetest_compute_instance" {
  source = "../../modules/compute_instance_v3_tfo"

  cell      = "guse4-poc"
  clusterid = "a"
  boot_disk = {
    size = "32", type = "pd-standard", device_name = "supper-boot"
  }
  # or in old format:
  # boot_disk_size   = 32
  # boot_disk_type   = "pd-standard"
  # boot_device_name = "supper-boot"
  instance_id  = 1
  machine_type = "g1-small"
  servertype   = "computetest"
  subnet_type  = "private"

  additional_disks = {
    "disk_01" = { size = "100", type = "pd-ssd" },
    "disk_02" = { size = "200" },
    "disk_03" = { size = "50", type = "pd-ssd" },
    "disk_04" = { size = "100", type = "pd-ssd" },
  }

  # pass through
  env     = var.env
  project = var.project
  region  = var.region

  labels = {
    owner     = "common_svcs_dev_priceline_com"
    dns       = ""
    inventory = ""
    ansible   = "done"
  }

  tags = [
    "infrastructure",
    "midtier-application"
  ]

}
