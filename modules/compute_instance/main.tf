#----------------------------------------------------------------------------
# compute_instance
#----------------------------------------------------------------------------

#----------------------------------------------------------------------------
# local variables
#----------------------------------------------------------------------------

locals {
  # map zones to list of compute instances created in them
  compute_instances_by_zone = {
    for i in range(length(google_compute_instance.default.*.self_link)) :
    data.google_compute_zones.available.names[(i + var.zone_to_start_with) % 3]
    => google_compute_instance.default.*.self_link[i]...
  }

  datacenter = module.gcp_varlib.region_to_datacenter[var.region]

  cluster_prefix = "${module.gcp_varlib.env_to_singlechar[var.env]}${var.clusterid}"
  name_prefix    = "${local.datacenter}-${var.servertype}-${local.cluster_prefix}"

  network_project = module.gcp_varlib.env_to_network_project[var.network_type][var.env]
  network_name    = module.gcp_varlib.network_project_to_network[local.network_project]

  number_of_zones = var.zones_limit
  zones_list      = concat(slice(data.google_compute_zones.available.names, var.zone_to_start_with, length(data.google_compute_zones.available.names)), slice(data.google_compute_zones.available.names, 0, var.zone_to_start_with))

  service_account = var.service_account != null ? var.service_account : "pl-${var.servertype}@${var.project}.iam.gserviceaccount.com"

  subnetwork_prefix = module.gcp_varlib.network_project_region_to_subnet[local.network_project][var.region]

  team = contains(keys(module.gcp_varlib.servertype_cloudcost_labels), var.servertype) ? module.gcp_varlib.servertype_cloudcost_labels[var.servertype]["team"] : ""

  instance_labels = {
    cell        = var.cell,
    environment = var.env
    server_type = var.servertype
    managed_by  = "terraform"
    bu          = local.team != "" ? module.gcp_varlib.team_cloudcost_labels[local.team]["bu"] : "tech"
    product     = local.team != "" ? module.gcp_varlib.team_cloudcost_labels[local.team]["product"] : "product_label"
    team        = local.team != "" ? local.team : "team_label"
    application = contains(keys(module.gcp_varlib.servertype_cloudcost_labels), var.servertype) ? module.gcp_varlib.servertype_cloudcost_labels[var.servertype]["application"] : var.servertype
  }

  sheriff_labels = {
    ansible   = "ready"
    dns       = ""
    inventory = ""
  }

  default_labels = (var.managed_by_sheriff == true ? merge(local.instance_labels, local.sheriff_labels) : local.instance_labels)

  default_metadata = {
    clusterid = "${module.gcp_varlib.env_to_singlechar[var.env]}${var.clusterid}"
    cell      = var.cell
  }

  default_tags = ["infrastructure", var.env, var.servertype]

  default_data_labels = {}
}

#----------------------------------------------------------------------------
# data requests
#----------------------------------------------------------------------------

data "google_compute_subnetwork" "private" {
  name    = "${local.subnetwork_prefix}-${var.subnet_type}"
  project = local.network_project
  region  = var.region
}

data "google_compute_subnetwork" "public" {
  name    = "${local.subnetwork_prefix}-public"
  project = local.network_project
  region  = var.region
}

data "google_compute_zones" "available" {
  region  = var.region
  project = var.project
}

data "google_compute_image" "image_family" {
  family  = var.image_family
  project = module.gcp_varlib.env_to_image_family_project[var.env]
}

#----------------------------------------------------------------------------
# compute resource creation
#----------------------------------------------------------------------------

# create data disk
resource "google_compute_disk" "data" {
  count = var.data_disk_size != null ? var.module_count : 0

  name = "${local.name_prefix}${format("%02d", count.index + var.sequence_to_start_with)}-${format("sd%s", module.gcp_varlib.alphabet[1])}"
  type = var.disk_type
  size = var.data_disk_size
  zone = element(local.zones_list, count.index % local.number_of_zones)

  labels = merge(local.default_data_labels, { used_by = "${local.name_prefix}${format("%02d", count.index + var.sequence_to_start_with)}" }, var.data_labels)

}

# attach data disk
resource "google_compute_attached_disk" "data" {
  count = var.data_disk_size != null ? var.module_count : 0

  disk     = google_compute_disk.data[count.index].self_link
  instance = google_compute_instance.default[count.index].self_link
}

resource "google_compute_instance" "default" {
  count = var.module_count

  name         = "${local.name_prefix}${format("%02d", count.index + var.sequence_to_start_with)}"
  zone         = element(local.zones_list, count.index % local.number_of_zones)
  machine_type = var.machine_type

  allow_stopping_for_update = var.allow_stopping_for_update

  min_cpu_platform = var.min_cpu_platform

  boot_disk {
    device_name = "boot"
    initialize_params {
      image = (var.image != "" ? var.image : length(var.image_map) > 0 ? var.image_map[count.index] : data.google_compute_image.image_family.self_link)
      size  = (length(var.disk_size_map) > 0 ? var.disk_size_map[count.index] : var.disk_size)
    }
  }

  network_interface {
    subnetwork_project = local.network_project
    subnetwork         = data.google_compute_subnetwork.private.self_link
    network_ip         = length(var.internal_ips) > 0 ? var.internal_ips[count.index] : null

    dynamic "access_config" {
      for_each = length(var.external_ips) > 0 ? [{ "nat_ip" = var.external_ips[count.index] }] : []
      content {
        nat_ip = access_config.value.nat_ip
      }
    }
  }

  dynamic "service_account" {
    for_each = var.disable_scopes == true ? [] : [1]

    content {
      email  = local.service_account
      scopes = var.scopes
    }
  }


  scheduling {
    on_host_maintenance = "MIGRATE"
    automatic_restart   = true
    preemptible         = var.preemptible
  }

  labels = merge(local.default_labels, { server_name = "${local.name_prefix}${format("%02d", count.index + var.sequence_to_start_with)}" }, var.labels)

  metadata = merge(local.default_metadata, var.metadata)

  tags = (var.no_default_tags == true ? var.tags : concat(local.default_tags, var.tags))

  lifecycle {
    ignore_changes = [
      attached_disk,
      labels["ansible"]
    ]
  }
}
