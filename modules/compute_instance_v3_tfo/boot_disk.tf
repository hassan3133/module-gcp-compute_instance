resource "google_compute_disk" "boot_disk" {

  name     = "${local.name_prefix}${format("%02d", var.instance_id)}"
  zone     = element(local.zones_list, local.instance_zone % local.number_of_zones)
  image    = lookup(var.boot_disk, "image", (lookup(var.boot_disk, "snapshot", null) != null ? null : (var.image != "" ? var.image : data.google_compute_image.image_family.self_link)))
  size     = lookup(var.boot_disk, "size", var.boot_disk_size)
  type     = lookup(var.boot_disk, "type", var.boot_disk_type)
  snapshot = lookup(var.boot_disk, "snapshot", null)
}
