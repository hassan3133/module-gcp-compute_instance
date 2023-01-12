locals {
  data_files   = fileset(path.module, "data/*_compute.yml")
  compute_data = [for f in local.data_files : yamldecode(file(f))]
  computes     = merge(merge(local.compute_data...), {})
}

module "computes" {
  //source = "git::https://github.com/pcln/terraform-gcp-compute_instance.git//modules/compute_instance_v3_tfo?ref=develop"
  source = "../../modules/compute_instance_v3_tfo"

  for_each = local.computes

  # base inputs
  cell        = each.value.cell
  clusterid   = each.value.clusterid
  servertype  = each.value.servertype
  subnet_type = each.value.subnet_type
  team        = each.value.team

  # permissions
  instanceAdminV1    = lookup(each.value, "permissions", {}) != {} ? lookup(each.value.permissions, "instanceAdminV1", []) : []
  instanceAdmin      = lookup(each.value, "permissions", {}) != {} ? lookup(each.value.permissions, "instanceAdmin", []) : []
  serviceAccountUser = lookup(each.value, "permissions", {}) != {} ? lookup(each.value.permissions, "serviceAccountUser", []) : []
  osLogin            = lookup(each.value, "permissions", {}) != {} ? lookup(each.value.permissions, "osLogin", []) : []

  # default values
  network_name_override            = lookup(each.value, "network_name_override", "")
  network_project_override         = lookup(each.value, "network_project_override", "")
  allow_stopping_for_update        = lookup(each.value, "allow_stopping_for_update", false)
  min_cpu_platform                 = lookup(each.value, "min_cpu_platform", "")
  additional_disks                 = lookup(each.value, "additional_disks", {})
  data_labels                      = lookup(each.value, "data_labels", {})
  deletion_protection              = lookup(each.value, "deletion_protection", true)
  boot_disk                        = lookup(each.value, "boot_disk", {})
  external_ips                     = lookup(each.value, "external_ips", [])
  health_check                     = lookup(each.value, "health_check", "tcp")
  health_check_port                = lookup(each.value, "health_check_port", null)
  image                            = lookup(each.value, "image", "")
  image_family                     = lookup(each.value, "image_family", "pcln-base-centos7")
  image_family_project             = lookup(each.value, "image_family_project", "")
  internal_ips                     = lookup(each.value, "internal_ips", "")
  labels                           = lookup(each.value, "labels", {})
  machine_type                     = lookup(each.value, "machine_type", "n1-standard-1")
  metadata                         = lookup(each.value, "metadata", {})
  preemptible                      = lookup(each.value, "preemptible", false)
  resource_policies                = lookup(each.value, "resource_policies", [])
  resource_policies_instance_count = lookup(each.value, "resource_policies_instance_count", 1000)
  service_account                  = lookup(each.value, "service_account", null)
  session_affinity                 = lookup(each.value, "session_affinity", "NONE")
  tags                             = lookup(each.value, "tags", [])
  zones_limit                      = lookup(each.value, "zones_limit", 3)
  zone_to_start_with               = lookup(each.value, "zone_to_start_with", 1)
  instance_id                      = lookup(each.value, "instance_id", 1)
  initial_sequence_of_instances    = lookup(each.value, "initial_sequence_of_instances", 1)
  managed_by_sheriff               = lookup(each.value, "managed_by_sheriff", true)
  no_default_tags                  = lookup(each.value, "no_default_tags", false)
  disable_scopes                   = lookup(each.value, "disable_scopes", false)
  scopes                           = lookup(each.value, "scopes", ["cloud-platform"])
  network_type                     = lookup(each.value, "network_type", "net")
  enable_display                   = lookup(each.value, "enable_display", false)
  shielded_instance_config         = lookup(each.value, "shielded_instance_config", {})
  palo_proxy_enabled               = lookup(each.value, "palo_proxy_enabled", true)

  # passthrough
  env     = var.env
  project = var.project
  region  = var.region
}
