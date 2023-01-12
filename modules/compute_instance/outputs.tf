#----------------------------------------------------------------------------
# outputs - module outputs
#----------------------------------------------------------------------------

output "compute_instance" {
  description = "Complete details of the compute instance(s)"
  value       = google_compute_instance.default
}

output "zones" {
  description = "Complete details of the compute instance(s)"
  value       = data.google_compute_zones.available
}

output "compute_instances_by_zone" {
  description = "map of compute instance(s) keyed by zone"
  value       = local.compute_instances_by_zone
}
