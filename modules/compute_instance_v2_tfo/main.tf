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

  service_account = var.service_account != null ? var.service_account : format("pl-%s@%s.iam.gserviceaccount.com", var.servertype, var.project)

  subnetwork_prefix = module.gcp_varlib.network_project_region_to_subnet[local.network_project][var.region]


  instance_labels = {
    cell        = var.cell,
    environment = var.env,
    server_type = var.servertype,
    managed_by  = "terraform",
    application = contains(keys(module.gcp_varlib.servertype_cloudcost_labels), var.servertype) ? module.gcp_varlib.servertype_cloudcost_labels[var.servertype]["application"] : var.servertype
  }

  sheriff_labels = {
    ansible   = "ready"
    dns       = ""
    inventory = ""
  }

  default_labels = (var.managed_by_sheriff == true ? merge(local.instance_labels, module.cloudcost_labels.labels, local.sheriff_labels) : merge(local.instance_labels, module.cloudcost_labels.labels))

  default_metadata = {
    clusterid = "${module.gcp_varlib.env_to_singlechar[var.env]}${var.clusterid}"
    cell      = var.cell
  }

  palo_tag = var.network_project_override == "pcln-pl-net-corp" ? module.gcp_varlib.paloproxy_region_network_tag["corp"][var.region] : module.gcp_varlib.paloproxy_region_network_tag[var.env][var.region]

  default_tags = (var.palo_proxy_enabled == true) && (length(var.external_ips) == 0) ? concat([local.palo_tag], ["infrastructure", var.env, var.servertype]) : ["infrastructure", var.env, var.servertype]

  default_data_labels = {}

  # checking for the existence of a service account
  sa_not_exist = data.google_service_account.service_account.email != null ? null : file("ERROR: service account ${local.service_account} doesn't exist")
}

#----------------------------------------------------------------------------
# data requests
#----------------------------------------------------------------------------

data "google_compute_subnetwork" "private" {
  name    = var.network_name_override != "" ? var.network_name_override : "${local.subnetwork_prefix}-${var.subnet_type}"
  project = var.network_project_override != "" ? var.network_project_override : local.network_project
  region  = var.region
}

data "google_compute_subnetwork" "public" {
  name    = var.network_name_override != "" ? var.network_name_override : "${local.subnetwork_prefix}-public"
  project = var.network_project_override != "" ? var.network_project_override : local.network_project
  region  = var.region
}

data "google_compute_zones" "available" {
  region  = var.region
  project = var.project
}

data "google_compute_image" "image_family" {
  family  = var.image_family
  project = var.image_family_project != "" ? var.image_family_project : module.gcp_varlib.env_to_image_family_project[var.env]
}

data "google_service_account" "service_account" {
  account_id = local.service_account
}

#----------------------------------------------------------------------------
# compute resource creation
#----------------------------------------------------------------------------
resource "google_compute_instance" "default" {
  count = var.module_count

  name                      = "${local.name_prefix}${format("%02d", count.index + var.sequence_to_start_with)}"
  zone                      = element(local.zones_list, count.index % local.number_of_zones)
  machine_type              = var.machine_type
  min_cpu_platform          = var.min_cpu_platform
  allow_stopping_for_update = var.allow_stopping_for_update
  deletion_protection       = var.deletion_protection
  enable_display            = var.enable_display

  labels   = merge(local.default_labels, { server_name = "${local.name_prefix}${format("%02d", count.index + var.sequence_to_start_with)}" }, var.labels)
  metadata = merge(local.default_metadata, var.metadata)
  tags     = (var.no_default_tags == true ? var.tags : concat(local.default_tags, var.tags))

  boot_disk {
    device_name = "boot"
    initialize_params {
      image = (var.image != "" ? var.image : length(var.image_map) > 0 ? var.image_map[count.index] : data.google_compute_image.image_family.self_link)
      size  = (length(var.boot_disk_size_map) > 0 ? var.boot_disk_size_map[count.index] : var.boot_disk_size)
      type  = (length(var.boot_disk_type_map) > 0 ? var.boot_disk_type_map[count.index] : var.boot_disk_type)
    }
  }

  network_interface {
    subnetwork_project = var.network_project_override != "" ? var.network_project_override : local.network_project
    subnetwork         = data.google_compute_subnetwork.private.self_link
    network_ip         = length(var.internal_ips) > 0 ? var.internal_ips[count.index] : null

    dynamic "access_config" {
      for_each = length(var.external_ips) > 0 ? [{ "nat_ip" = var.external_ips[count.index] }] : []
      content {
        nat_ip = access_config.value.nat_ip
      }
    }
  }

  scheduling {
    on_host_maintenance = "MIGRATE"
    automatic_restart   = true
    preemptible         = var.preemptible
  }

  lifecycle {
    ignore_changes = [
      attached_disk,
      labels["ansible"]
    ]
  }

  resource_policies = ((length(var.resource_policies) > 0) && (count.index < var.resource_policies_instance_count)) ? var.resource_policies : []

  dynamic "service_account" {
    for_each = var.disable_scopes == true ? [] : [1]

    content {
      email  = data.google_service_account.service_account.email
      scopes = var.scopes
    }
  }

  dynamic "shielded_instance_config" {
    for_each = length(keys(var.shielded_instance_config)) > 0 ? [1] : []

    content {
      enable_secure_boot          = lookup(var.shielded_instance_config, "enable_secure_boot", false)
      enable_vtpm                 = lookup(var.shielded_instance_config, "enable_vtpm", false)
      enable_integrity_monitoring = lookup(var.shielded_instance_config, "enable_integrity_monitoring", false)
    }
  }
}

#----------------------------------------------------------------------------
# permissions
#----------------------------------------------------------------------------

resource "google_compute_instance_iam_binding" "instanceAdminV1" {
  count         = length(var.instanceAdminV1) > 0 ? var.module_count : 0
  project       = google_compute_instance.default[count.index].project
  zone          = google_compute_instance.default[count.index].zone
  instance_name = google_compute_instance.default[count.index].name
  role          = "roles/compute.instanceAdmin.v1"
  members       = var.instanceAdminV1
}

resource "google_compute_instance_iam_binding" "instanceAdmin" {
  count         = length(var.instanceAdmin) > 0 ? var.module_count : 0
  project       = google_compute_instance.default[count.index].project
  zone          = google_compute_instance.default[count.index].zone
  instance_name = google_compute_instance.default[count.index].name
  role          = "roles/compute.instanceAdmin"
  members       = var.instanceAdmin
}

resource "google_compute_instance_iam_binding" "osLogin" {
  count         = length(var.osLogin) > 0 ? var.module_count : 0
  project       = google_compute_instance.default[count.index].project
  zone          = google_compute_instance.default[count.index].zone
  instance_name = google_compute_instance.default[count.index].name
  role          = "roles/compute.osLogin"
  members       = var.osLogin
}

resource "google_compute_instance_iam_binding" "serviceAccountUser" {
  count         = length(var.serviceAccountUser) > 0 ? var.module_count : 0
  project       = google_compute_instance.default[count.index].project
  zone          = google_compute_instance.default[count.index].zone
  instance_name = google_compute_instance.default[count.index].name
  role          = "roles/iam.serviceAccountUser"
  members       = var.serviceAccountUser
}
