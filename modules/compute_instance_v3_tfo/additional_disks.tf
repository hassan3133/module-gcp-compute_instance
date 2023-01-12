
resource "google_compute_disk" "additional_disk" {
  for_each = var.additional_disks

  name     = "${local.name_prefix}${format("%02d", var.instance_id)}-${substr(md5(format("%s-%s", var.instance_id, each.key)), 0, 5)}"
  type     = lookup(each.value, "type", var.additional_disk_type)
  size     = each.value["size"]
  zone     = element(local.zones_list, local.instance_zone % local.number_of_zones)
  image    = lookup(each.value, "image", null)
  snapshot = lookup(each.value, "snapshot", null)

  labels = merge(local.default_data_labels, { used_by = "${local.name_prefix}${format("%02d", var.instance_id)}" }, var.data_labels)
}

resource "google_compute_attached_disk" "additional_disk" {
  for_each = var.additional_disks

  device_name = lookup(each.value, "device_name", null)
  disk        = google_compute_disk.additional_disk[each.key].self_link
  instance    = google_compute_instance.default.self_link
}
