locals {
  disk_matrix = setproduct(range(var.module_count), var.multiple_data_disks)
  umap        = { for i in range(var.module_count * length(var.multiple_data_disks)) : (md5(local.disk_matrix[i][0] + local.disk_matrix[i][1])) => i }
}


resource "google_compute_disk" "mdata" {
  for_each = length(keys(local.umap)) > 0 ? local.umap : {}

  name = "${local.name_prefix}${format("%02d", local.disk_matrix[each.value][0] + var.sequence_to_start_with)}-${substr(each.key, 0, 5)}"
  type = var.disk_type
  size = local.disk_matrix[each.value][1]
  zone = element(local.zones_list, local.disk_matrix[each.value][0] % local.number_of_zones)

  labels = merge(local.default_data_labels, { used_by = "${local.name_prefix}${format("%02d", local.disk_matrix[each.value][0] + var.sequence_to_start_with)}" }, var.data_labels)
}

resource "google_compute_attached_disk" "mdata" {
  for_each = length(keys(local.umap)) > 0 ? local.umap : {}

  disk     = google_compute_disk.mdata[each.key].self_link
  instance = google_compute_instance.default[local.disk_matrix[each.value][0]].self_link
}
