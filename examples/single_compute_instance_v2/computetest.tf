#----------------------------------------------------------------------------
# computetest
#----------------------------------------------------------------------------

module "computetest_compute_instance" {
  source = "../../modules/compute_instance_v2_tfo"

  module_count   = 3
  cell           = "guse4-poc"
  clusterid      = "a"
  boot_disk_size = 32
  ## if you need to set different boot disk sizes for each instance
  # boot_disk_size_map = {
  #   "0" = 32
  #   "1" = 10
  #   "2" = 10
  # }
  boot_disk_type = "pd-standard"
  ## if you need to set different boot disk types for each instance
  # boot_disk_type_map = {
  #   "0" = "pd-standard"
  #   "1" = "pd-ssd"
  #   "2" = "pd-standard"
  # }
  machine_type = "g1-small"
  servertype   = "computetest"
  subnet_type  = "private"

  #where 1st - instance id to attach disk, 2nd - disk size, 3d - disk type (by default pd-ssd)
  additional_disk_map = {
    "disk_01" = ["0", "100", "pd-ssd"],
    "disk_02" = ["0", "200"],
    "disk_03" = ["2", "300", "pd-standart"],
    "disk_04" = ["1", "400", "pd-ssd"],
    "disk_05" = ["0", "500"]
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
