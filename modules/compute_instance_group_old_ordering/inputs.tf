#----------------------------------------------------------------------------
# inputs - module parameters
#----------------------------------------------------------------------------

variable "clusterid" {
  description = "an alphabetic character representing the cluster"
  type        = string
}

variable "compute_instances_by_zone" {
  description = "map of compute instance self_links by zone"
  type        = map(any)
}

variable "create_before_destroy" {
  description = "create before destroy lifecycle"
  type        = bool
  default     = false
}

variable "env" {
  description = "the environment"
  type        = string
}

variable "named_ports" {
  type = list(object({
    name = string
    port = number
  }))
  default = [
    {
      name = "https"
      port = 443
    }
  ]
}

variable "region" {
  description = "a google cloud platform region"
  type        = string
}

variable "project" {
  description = "The ID of the project in which the resource belongs. If it is not provided, the provider project is used."
  type        = string
}

variable "servertype" {
  description = "a priceline server type"
  type        = string
}
