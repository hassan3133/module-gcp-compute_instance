#----------------------------------------------------------------------------
# compute_instance
#----------------------------------------------------------------------------

#----------------------------------------------------------------------------
# local variables
#----------------------------------------------------------------------------

locals {
  datacenter = module.gcp_varlib.region_to_datacenter[var.region]

  cluster_prefix = "${module.gcp_varlib.env_to_singlechar[var.env]}${var.clusterid}"
  name_prefix    = "${local.datacenter}-${var.servertype}-${local.cluster_prefix}"
  index_offset   = length(keys(var.compute_instances_by_zone)) > 2 ? 1 : 0
}

#----------------------------------------------------------------------------
# data requests
#----------------------------------------------------------------------------

#----------------------------------------------------------------------------
# resource creation
#----------------------------------------------------------------------------

resource "google_compute_instance_group" "default" {
  count = length(keys(var.compute_instances_by_zone))
  name  = "${local.name_prefix}-ig${substr(element(keys(var.compute_instances_by_zone), count.index + local.index_offset + var.zone_to_start_with), -1, 1)}"
  zone  = element(keys(var.compute_instances_by_zone), count.index + local.index_offset + var.zone_to_start_with)

  instances = var.compute_instances_by_zone[element(keys(var.compute_instances_by_zone), count.index + local.index_offset + var.zone_to_start_with)]

  dynamic "named_port" {
    for_each = var.named_ports
    content {
      name = named_port.value["name"]
      port = named_port.value["port"]
    }
  }

  lifecycle {
    create_before_destroy = true # var.create_before_destroy
  }
}
