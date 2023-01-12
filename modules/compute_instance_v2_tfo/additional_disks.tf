
resource "google_compute_disk" "additional_disk" {
  for_each = var.additional_disk_map

  name = "${local.name_prefix}${format("%02d", each.value[0] + var.sequence_to_start_with)}-${substr(md5(format("%s-%s", each.value[0], each.key)), 0, 5)}"
  type = length(each.value) > 2 ? each.value[2] : var.additional_disk_type
  size = each.value[1]
  zone = element(local.zones_list, each.value[0] % local.number_of_zones)

  labels = merge(local.default_data_labels, { used_by = "${local.name_prefix}${format("%02d", each.value[0] + var.sequence_to_start_with)}" }, var.data_labels)
}

resource "google_compute_attached_disk" "additional_disk" {
  for_each = var.additional_disk_map

  device_name = length(each.value) > 3 ? each.value[3] : null
  disk        = google_compute_disk.additional_disk[each.key].self_link
  instance    = google_compute_instance.default[each.value[0]].self_link
}
