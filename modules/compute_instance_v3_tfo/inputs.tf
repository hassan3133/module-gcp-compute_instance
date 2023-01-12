#----------------------------------------------------------------------------
# inputs - module parameters
#----------------------------------------------------------------------------

variable "network_name_override" {
  description = "Override the network name"
  type        = string
  default     = ""
}

variable "network_project_override" {
  description = "Override the network name"
  type        = string
  default     = ""
}

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

variable "data_labels" {
  description = "A set of key/value label pairs to assign to the persistent disk."
  type        = map(any)
  default     = {}
}

variable "deletion_protection" {
  description = "Deletion Protection"
  type        = bool
  default     = true
}

variable "boot_disk" {
  description = "Size of the persistent disk, specified in GB. You can specify this field when creating a persistent disk using the sourceImage or sourceSnapshot parameter, or specify it alone to create an empty persistent disk. If you specify this field along with sourceImage or sourceSnapshot, the value of sizeGb must not be less than the size of the sourceImage or the size of the snapshot."
  type        = map(any)
  default     = {}
}

variable "boot_disk_size" {
  description = "Size of the persistent disk, specified in GB. You can specify this field when creating a persistent disk using the sourceImage or sourceSnapshot parameter, or specify it alone to create an empty persistent disk. If you specify this field along with sourceImage or sourceSnapshot, the value of sizeGb must not be less than the size of the sourceImage or the size of the snapshot."
  type        = number
  default     = 32
}

variable "boot_disk_type" {
  description = "Type of the boot persistent disk. May be set to pd-standard, pd-balanced or pd-ssd."
  type        = string
  default     = "pd-standard"
}

variable "boot_device_name" {
  description = "Boot disk device name"
  type        = string
  default     = "boot"
}

variable "boot_snapshot" {
  description = "Boot disk snapshot"
  type        = string
  default     = ""
}

variable "additional_disks" {
  description = "Map of specific data disk sizes, types to specific instance sequence numbers"
  type        = map(any)
  default     = {}
}

variable "additional_disk_type" {
  description = "Type of the additional persistent disk. May be set to pd-standard, pd-balanced or pd-ssd."
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

variable "image_family" {
  description = "The name of a specific image or a family.  It will returns the latest image that is part of an image family and is not deprecated."
  type        = string
  default     = "pcln-base-centos7"
}

variable "image_family_project" {
  description = "The name of a specific custom project to get images from."
  type        = string
  default     = ""
}

variable "internal_ips" {
  description = "internal compute instance ip address type"
  type        = string
  default     = ""
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

# variable "module_count" {
#   description = "integer for the number of resources to create"
#   type        = number
#   default     = 1
# }

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

variable "resource_policies" {
  description = "A list of resource policies to attach to the instance."
  type        = list(any)
  default     = []
}

variable "resource_policies_instance_count" {
  description = "A number of instances to which a resource policy will be applied. If there 10 instances and this var is set to 5, 5 instances will have the policy attached and 5 won't"
  type        = number
  default     = 1000
}

variable "servertype" {
  description = "a priceline server type"
  type        = string
}

variable "service_account" {
  description = "a compute service account"
  type        = string
  default     = null
  validation {
    condition     = var.service_account == null ? true : (length(regex("^.*@", var.service_account)) - 1 <= 30 && length(regex("^.*@", var.service_account)) - 1 >= 6 && can(regex("^\\w+([-+.']\\w+)*@(\\w+([-.]\\w+)*\\b(.iam.gserviceaccount.com)\\b|\\b(developer.gserviceaccount.com)\\b)*$", var.service_account)))
    error_message = "The SA_NAME must be between 6 and 30 characters, and can contain lowercase alphanumeric characters and dashes. Format: SA_NAME@PROJECT_ID.iam.gserviceaccount.com."
  }
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

variable "team" {
  description = "Name of the team that owns the instance"
  type        = string
  default     = ""
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

variable "instance_id" {
  description = "sequence number to assign to a name of the instance of servertype set, default is 1"
  type        = number
  default     = 1
}

variable "initial_sequence_of_instances" {
  description = "set to 0 if the initial sequence instance has an instance_id of 0, not 1"
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

variable "enable_display" {
  description = "(Optional) Enable Virtual Displays on this instance."
  type        = bool
  default     = false
}

variable "shielded_instance_config" {
  description = "shielded_instance_config settings"
  type        = map(any)
  default     = {}
}

variable "instanceAdminV1" {
  description = "List of instanceAdminV1 members"
  type        = list(any)
  default     = []
  validation {
    condition     = can([for b in var.instanceAdminV1 : regex("^(serviceAccount|group|user):\\w+([-+.']\\w+)*@\\w+([-.]\\w+)*\\.\\w+([-.]\\w+)*$", b)])
    error_message = "Valid values for instanceAdminV1 are: serviceAccount, group or user followed by : and an email address (eg group:techteam@priceline)."
  }
}

variable "instanceAdmin" {
  description = "List of instanceAdmin members"
  type        = list(any)
  default     = []
  validation {
    condition     = can([for b in var.instanceAdmin : regex("^(serviceAccount|group|user):\\w+([-+.']\\w+)*@\\w+([-.]\\w+)*\\.\\w+([-.]\\w+)*$", b)])
    error_message = "Valid values for instanceAdmin are: serviceAccount, group or user followed by : and an email address (eg group:techteam@priceline)."
  }
}

variable "osLogin" {
  description = "List of osLogin members"
  type        = list(any)
  default     = []
  validation {
    condition     = can([for b in var.osLogin : regex("^(serviceAccount|group|user):\\w+([-+.']\\w+)*@\\w+([-.]\\w+)*\\.\\w+([-.]\\w+)*$", b)])
    error_message = "Valid values for osLogin are: serviceAccount, group or user followed by : and an email address (eg group:techteam@priceline)."
  }
}

variable "serviceAccountUser" {
  description = "List of serviceAccountUser members"
  type        = list(any)
  default     = []
  validation {
    condition     = can([for b in var.serviceAccountUser : regex("^(serviceAccount|group|user):\\w+([-+.']\\w+)*@\\w+([-.]\\w+)*\\.\\w+([-.]\\w+)*$", b)])
    error_message = "Valid values for serviceAccountUser are: serviceAccount, group or user followed by : and an email address (eg group:techteam@priceline)."
  }
}

variable "palo_proxy_enabled" {
  description = "Enable transparent proxy"
  type        = bool
  default     = true
}
