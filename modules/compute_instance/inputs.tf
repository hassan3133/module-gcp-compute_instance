#----------------------------------------------------------------------------
# inputs - module parameters
#----------------------------------------------------------------------------

variable "allow_stopping_for_update" {
  description = "allow_stopping_for_update"
  type        = bool
  default     = false
}

variable "cell" {
  description = "a priceline cell"
  type        = string
}

variable "clusterid" {
  description = "an alphabetic character representing the cluster"
  type        = string
}

variable "min_cpu_platform" {
  description = "CPU platform for the instance, e.g. Broadwell or Haswell"
  type        = string
  default     = ""
}

variable "data_disk_size" {
  description = "Size of the persistent disk, specified in GB."
  type        = number
  default     = null
}

variable "data_labels" {
  description = "A set of key/value label pairs to assign to the persistent disk."
  type        = map(any)
  default     = {}
}

variable "disk_size" {
  description = "Size of the persistent disk, specified in GB. You can specify this field when creating a persistent disk using the sourceImage or sourceSnapshot parameter, or specify it alone to create an empty persistent disk. If you specify this field along with sourceImage or sourceSnapshot, the value of sizeGb must not be less than the size of the sourceImage or the size of the snapshot."
  type        = number
  default     = 32
}

variable "disk_size_map" {
  description = "Map of specific disk sizes to specific instance sequence numbers"
  type        = map(any)
  default     = {}
}

variable "disk_type" {
  description = "URL of the disk type resource describing which disk type to use to create the disk. Provide this when creating the disk."
  type        = string
  default     = "pd-ssd"
}

variable "env" {
  description = "the environment"
  type        = string
}

variable "external_ips" {
  description = "list of external compute instance ip address - put blank array elements '' for ephemeral ips. ONLY hardcoat static reserved IP's"
  type        = list(any)
  default     = []
}

variable "health_check" {
  description = "type of health check"
  type        = string
  default     = "tcp"
}

variable "health_check_port" {
  description = "port health check checks against"
  type        = number
  default     = null
}

variable "image" {
  description = "The name of a specific image.  When provided, it overrides the image_family variable."
  type        = string
  default     = ""
}

variable "image_map" {
  description = "Map of specific images to specific instance sequence numbers"
  type        = map(any)
  default     = {}
}

variable "image_family" {
  description = "The name of a specific image or a family.  It will returns the latest image that is part of an image family and is not deprecated."
  type        = string
  default     = "pcln-base-centos7"
}

variable "internal_ips" {
  description = "internal compute instance ip address type"
  type        = list(any)
  default     = []
}

variable "labels" {
  description = "A set of key/value label pairs to assign to the instance"
  type        = map(any)
  default     = {}
}

variable "machine_type" {
  description = <<EOD
The machine type to create
https://cloud.google.com/compute/docs/machine-types
EOD
  type        = string
  default     = "n1-standard-1"
}

variable "metadata" {
  description = <<EOD
"Metadata key/value pairs to make available from within the instance. Ssh keys attached in the Cloud Console will be removed. Add them to your config in order to keep them attached to your instance"
EOD
  type        = map(any)
  default     = {}
}

variable "module_count" {
  description = "integer for the number of resources to create"
  type        = number
  default     = 1
}

variable "region" {
  description = "a google cloud platform region"
  type        = string
}

variable "preemptible" {
  description = "is the instance preemptible"
  type        = bool
  default     = false
}

variable "project" {
  description = "The ID of the project in which the resource belongs. If it is not provided, the provider project is used."
  type        = string
}

variable "servertype" {
  description = "a priceline server type"
  type        = string
}

variable "service_account" {
  description = "a compute service account"
  type        = string
  default     = null
}

variable "session_affinity" {
  description = "Type of session affinity to use. The default is NONE. Can be NONE, CLIENT_IP, CLIENT_IP_PROTO, or CLIENT_IP_PORT_PROTO. When the protocol is UDP, this field is not used"
  type        = string
  default     = "NONE"
}

variable "subnet_type" {
  description = "a subnet type"
  type        = string
}

variable "tags" {
  description = "A list of tags to attach to the instance."
  type        = list(any)
  default     = []
}

variable "zones_limit" {
  description = "Limit number of zones."
  type        = number
  default     = 3
}

variable "zone_to_start_with" {
  description = "zone to assign to first instance of servertype set, default is b"
  type        = number
  default     = 1
}

variable "sequence_to_start_with" {
  description = "sequence number to assign to a name of the first instance of servertype set, default is 1"
  type        = number
  default     = 1
}

variable "managed_by_sheriff" {
  description = "If set adds the dns, inventory and ansible labels to the instance, default behaviour is to add the sheriff labels"
  type        = bool
  default     = true
}

variable "no_default_tags" {
  description = "If set only the tags passed in from the calling module are added to the instance"
  type        = bool
  default     = false
}

variable "disable_scopes" {
  description = "If set do not add service account block"
  type        = bool
  default     = false
}

variable "scopes" {
  description = "If set does not add scopes to service account block"
  type        = list(string)
  default     = ["cloud-platform"]
}

variable "network_type" {
  // refer to env_to_network_project variable in https://github.com/pcln/terraform-gcp-varlib
  description = "used to identify the network"
  type        = string
  default     = "net"
}
