#----------------------------------------------------------------------------
# compute_instance_with_internal_loadbalancer
#----------------------------------------------------------------------------

#----------------------------------------------------------------------------
# local variables
#----------------------------------------------------------------------------

locals {
  datacenter = module.gcp_varlib.region_to_datacenter[var.region]

  cluster_prefix = "${module.gcp_varlib.env_to_singlechar[var.env]}${var.clusterid}"
  name_prefix    = "${local.datacenter}-${var.servertype}-${local.cluster_prefix}"
}

#----------------------------------------------------------------------------
# data requests
#----------------------------------------------------------------------------

#----------------------------------------------------------------------------
# compute resource creation
#----------------------------------------------------------------------------
module "compute_instance" {

  source       = "../compute_instance/"
  module_count = var.module_count

  # pass through
  cell            = var.cell
  clusterid       = var.clusterid
  disk_size       = var.disk_size
  external_ips    = var.external_ips
  image           = var.image
  internal_ips    = var.internal_ips
  machine_type    = var.machine_type
  servertype      = var.servertype
  service_account = var.service_account
  subnet_type     = var.subnet_type
  env             = var.env
  project         = var.project
  region          = var.region

  labels = var.labels

  tags = var.tags
}

module "compute_instance_group" {

  source = "../compute_instance_group/"

  clusterid                 = var.clusterid
  create_before_destroy     = true
  env                       = var.env
  project                   = var.project
  region                    = var.region
  servertype                = var.servertype
  compute_instances_by_zone = module.compute_instance.compute_instances_by_zone
}

module "internal_loadbalancer" {

  source = "git::https://github.com/pcln/terraform-gcp-internal_loadbalancer.git//modules/internal_loadbalancer_tfo/"

  backends = module.compute_instance_group.self_links

  clusterid         = var.clusterid
  description       = var.description
  health_check_port = var.health_check_port
  env               = var.env
  ip_address        = var.ip_address
  ports             = ["443"]
  project           = var.project
  region            = var.region
  servertype        = var.servertype
  service_label     = var.service_label
  tags              = var.tags
}
