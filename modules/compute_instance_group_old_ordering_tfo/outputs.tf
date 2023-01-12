#----------------------------------------------------------------------------
# outputs - module outputs
#----------------------------------------------------------------------------

output "self_links" {
  description = "self link to generated compute instance group"
  value       = google_compute_instance_group.default.*.self_link
}
