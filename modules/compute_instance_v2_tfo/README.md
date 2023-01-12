## Compute Instance
![Maintained by Priceline.com](https://img.shields.io/badge/maintained%20by-priceline.com-blue)
![Terraform Version](https://img.shields.io/badge/tf-%3E%3D0.13-blue.svg)

### Usage

```
module "computetest_compute_instance" {
  source = "../../modules/compute_instance_v2_tfo"

  module_count   = 3
  cell           = "guse4-poc"
  clusterid      = "a"
  boot_disk_size = 32
  ## if you need to set different boot disk sizes for each instance
  # boot_disk_size_map = {
  #   "0" = 32
  #   "1" = 10
  #   "2" = 10
  # }
  boot_disk_type = "pd-standard"
  ## if you need to set different boot disk types for each instance
  # boot_disk_type_map = {
  #   "0" = "pd-standard"
  #   "1" = "pd-ssd"
  #   "2" = "pd-standard"
  # }
  machine_type   = "g1-small"
  servertype     = "computetest"
  subnet_type    = "private"

  #where 1st - instance id to attach disk, 2nd - disk size, 3d - disk type (by default pd-ssd), 4th - device name
  additional_disk_map = {
    "disk_01" = ["0", "100", "pd-ssd"],
    "disk_02" = ["0", "200"],
    "disk_03" = ["2", "300", "pd-standart"],
    "disk_04" = ["1", "400", "pd-ssd"],
    "disk_05" = ["0", "500"]
  }
  #if you want to specify 4th parameter - it's mandatory to specify 1-3 and you should specify it for all additional disks
  #example of using 4th (device name) parametr:
  #additional_disk_map = {
  #  "disk_01" = ["0", "500", "pd-ssd", "persistent-disk-1"],
  #  "disk_02" = ["0", "4000", "pd-ssd", "persistent-disk-2"],
  #  "disk_03" = ["1", "500", "pd-ssd", "persistent-disk-1"],
  #  "disk_04" = ["1", "4000", "pd-ssd", "persistent-disk-2"],
  #  "disk_05" = ["2", "500", "pd-ssd", "persistent-disk-1"],
  #  "disk_06" = ["2", "4000", "pd-ssd", "persistent-disk-2"],
  #}

  # pass through
  env     = var.env
  project = var.project
  region  = var.region

  labels = {
    owner     = "common_svcs_dev_priceline_com"
    dns       = ""
    inventory = ""
    ansible   = "done"
  }

  tags = [
    "infrastructure",
    "midtier-application"
  ]

}
```

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->

<!-- BEGIN_TF_DOCS -->
#### Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_cloudcost_labels"></a> [cloudcost_labels](#module_cloudcost_labels) | git::https://github.com/pcln/terraform-curl-cloudcost_labels.git//modules/cloudcost_labels | n/a |
| <a name="module_gcp_varlib"></a> [gcp_varlib](#module_gcp_varlib) | git::https://github.com/pcln/terraform-gcp-varlib.git//modules/gcp_varlib | n/a |

#### Resources

| Name | Type |
|------|------|
| [google_compute_attached_disk.additional_disk](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_attached_disk) | resource |
| [google_compute_disk.additional_disk](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_disk) | resource |
| [google_compute_instance.default](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_instance) | resource |
| [google_compute_instance_iam_binding.instanceAdmin](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_instance_iam_binding) | resource |
| [google_compute_instance_iam_binding.instanceAdminV1](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_instance_iam_binding) | resource |
| [google_compute_instance_iam_binding.osLogin](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_instance_iam_binding) | resource |
| [google_compute_instance_iam_binding.serviceAccountUser](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_instance_iam_binding) | resource |

#### Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_cell"></a> [cell](#input_cell) | a priceline cell | `string` | n/a | yes |
| <a name="input_clusterid"></a> [clusterid](#input_clusterid) | an alphabetic character representing the cluster | `string` | n/a | yes |
| <a name="input_env"></a> [env](#input_env) | the environment | `string` | n/a | yes |
| <a name="input_project"></a> [project](#input_project) | The ID of the project in which the resource belongs. If it is not provided, the provider project is used. | `string` | n/a | yes |
| <a name="input_region"></a> [region](#input_region) | a google cloud platform region | `string` | n/a | yes |
| <a name="input_servertype"></a> [servertype](#input_servertype) | a priceline server type | `string` | n/a | yes |
| <a name="input_subnet_type"></a> [subnet_type](#input_subnet_type) | a subnet type | `string` | n/a | yes |
| <a name="input_additional_disk_map"></a> [additional_disk_map](#input_additional_disk_map) | Map of specific data disk sizes, types to specific instance sequence numbers | `map(any)` | `{}` | no |
| <a name="input_additional_disk_type"></a> [additional_disk_type](#input_additional_disk_type) | Type of the additional persistent disk. May be set to pd-standard, pd-balanced or pd-ssd. | `string` | `"pd-ssd"` | no |
| <a name="input_allow_stopping_for_update"></a> [allow_stopping_for_update](#input_allow_stopping_for_update) | allow_stopping_for_update | `bool` | `false` | no |
| <a name="input_boot_disk_size"></a> [boot_disk_size](#input_boot_disk_size) | Size of the persistent disk, specified in GB. You can specify this field when creating a persistent disk using the sourceImage or sourceSnapshot parameter, or specify it alone to create an empty persistent disk. If you specify this field along with sourceImage or sourceSnapshot, the value of sizeGb must not be less than the size of the sourceImage or the size of the snapshot. | `number` | `32` | no |
| <a name="input_boot_disk_size_map"></a> [boot_disk_size_map](#input_boot_disk_size_map) | Map of specific disk sizes to specific instance sequence numbers | `map(any)` | `{}` | no |
| <a name="input_boot_disk_type"></a> [boot_disk_type](#input_boot_disk_type) | Type of the boot persistent disk. May be set to pd-standard, pd-balanced or pd-ssd. | `string` | `"pd-standard"` | no |
| <a name="input_boot_disk_type_map"></a> [boot_disk_type_map](#input_boot_disk_type_map) | Map of specific disk types to specific instance sequence numbers | `map(any)` | `{}` | no |
| <a name="input_data_labels"></a> [data_labels](#input_data_labels) | A set of key/value label pairs to assign to the persistent disk. | `map(any)` | `{}` | no |
| <a name="input_deletion_protection"></a> [deletion_protection](#input_deletion_protection) | Deletion Protection | `bool` | `true` | no |
| <a name="input_disable_scopes"></a> [disable_scopes](#input_disable_scopes) | If set do not add service account block | `bool` | `false` | no |
| <a name="input_enable_display"></a> [enable_display](#input_enable_display) | (Optional) Enable Virtual Displays on this instance. | `bool` | `false` | no |
| <a name="input_external_ips"></a> [external_ips](#input_external_ips) | list of external compute instance ip address - put blank array elements '' for ephemeral ips. ONLY hardcoat static reserved IP's | `list(any)` | `[]` | no |
| <a name="input_health_check"></a> [health_check](#input_health_check) | type of health check | `string` | `"tcp"` | no |
| <a name="input_health_check_port"></a> [health_check_port](#input_health_check_port) | port health check checks against | `number` | `null` | no |
| <a name="input_image"></a> [image](#input_image) | The name of a specific image.  When provided, it overrides the image_family variable. | `string` | `""` | no |
| <a name="input_image_family"></a> [image_family](#input_image_family) | The name of a specific image or a family.  It will returns the latest image that is part of an image family and is not deprecated. | `string` | `"pcln-base-centos7"` | no |
| <a name="input_image_family_project"></a> [image_family_project](#input_image_family_project) | The name of a specific custom project to get images from. | `string` | `""` | no |
| <a name="input_image_map"></a> [image_map](#input_image_map) | Map of specific images to specific instance sequence numbers | `map(any)` | `{}` | no |
| <a name="input_instanceAdmin"></a> [instanceAdmin](#input_instanceAdmin) | List of instanceAdmin members | `list(any)` | `[]` | no |
| <a name="input_instanceAdminV1"></a> [instanceAdminV1](#input_instanceAdminV1) | List of instanceAdminV1 members | `list(any)` | `[]` | no |
| <a name="input_internal_ips"></a> [internal_ips](#input_internal_ips) | internal compute instance ip address type | `list(any)` | `[]` | no |
| <a name="input_labels"></a> [labels](#input_labels) | A set of key/value label pairs to assign to the instance | `map(any)` | `{}` | no |
| <a name="input_machine_type"></a> [machine_type](#input_machine_type) | The machine type to create<br>https://cloud.google.com/compute/docs/machine-types | `string` | `"n1-standard-1"` | no |
| <a name="input_managed_by_sheriff"></a> [managed_by_sheriff](#input_managed_by_sheriff) | If set adds the dns, inventory and ansible labels to the instance, default behaviour is to add the sheriff labels | `bool` | `true` | no |
| <a name="input_metadata"></a> [metadata](#input_metadata) | "Metadata key/value pairs to make available from within the instance. Ssh keys attached in the Cloud Console will be removed. Add them to your config in order to keep them attached to your instance" | `map(any)` | `{}` | no |
| <a name="input_min_cpu_platform"></a> [min_cpu_platform](#input_min_cpu_platform) | CPU platform for the instance, e.g. Broadwell or Haswell | `string` | `""` | no |
| <a name="input_module_count"></a> [module_count](#input_module_count) | integer for the number of resources to create | `number` | `1` | no |
| <a name="input_network_name_override"></a> [network_name_override](#input_network_name_override) | Override the network name | `string` | `""` | no |
| <a name="input_network_project_override"></a> [network_project_override](#input_network_project_override) | Override the network name | `string` | `""` | no |
| <a name="input_network_type"></a> [network_type](#input_network_type) | used to identify the network | `string` | `"net"` | no |
| <a name="input_no_default_tags"></a> [no_default_tags](#input_no_default_tags) | If set only the tags passed in from the calling module are added to the instance | `bool` | `false` | no |
| <a name="input_osLogin"></a> [osLogin](#input_osLogin) | List of osLogin members | `list(any)` | `[]` | no |
| <a name="input_palo_proxy_enabled"></a> [palo_proxy_enabled](#input_palo_proxy_enabled) | Enable transparent proxy | `bool` | `true` | no |
| <a name="input_preemptible"></a> [preemptible](#input_preemptible) | is the instance preemptible | `bool` | `false` | no |
| <a name="input_resource_policies"></a> [resource_policies](#input_resource_policies) | A list of resource policies to attach to the instance. | `list(any)` | `[]` | no |
| <a name="input_resource_policies_instance_count"></a> [resource_policies_instance_count](#input_resource_policies_instance_count) | A number of instances to which a resource policy will be applied. If there 10 instances and this var is set to 5, 5 instances will have the policy attached and 5 won't | `number` | `1000` | no |
| <a name="input_scopes"></a> [scopes](#input_scopes) | If set does not add scopes to service account block | `list(string)` | <pre>[<br>  "cloud-platform"<br>]</pre> | no |
| <a name="input_sequence_to_start_with"></a> [sequence_to_start_with](#input_sequence_to_start_with) | sequence number to assign to a name of the first instance of servertype set, default is 1 | `number` | `1` | no |
| <a name="input_serviceAccountUser"></a> [serviceAccountUser](#input_serviceAccountUser) | List of serviceAccountUser members | `list(any)` | `[]` | no |
| <a name="input_service_account"></a> [service_account](#input_service_account) | a compute service account | `string` | `null` | no |
| <a name="input_session_affinity"></a> [session_affinity](#input_session_affinity) | Type of session affinity to use. The default is NONE. Can be NONE, CLIENT_IP, CLIENT_IP_PROTO, or CLIENT_IP_PORT_PROTO. When the protocol is UDP, this field is not used | `string` | `"NONE"` | no |
| <a name="input_shielded_instance_config"></a> [shielded_instance_config](#input_shielded_instance_config) | shielded_instance_config settings | `map(any)` | `{}` | no |
| <a name="input_tags"></a> [tags](#input_tags) | A list of tags to attach to the instance. | `list(any)` | `[]` | no |
| <a name="input_team"></a> [team](#input_team) | Name of the team that owns the instance | `string` | `""` | no |
| <a name="input_zone_to_start_with"></a> [zone_to_start_with](#input_zone_to_start_with) | zone to assign to first instance of servertype set, default is b | `number` | `1` | no |
| <a name="input_zones_limit"></a> [zones_limit](#input_zones_limit) | Limit number of zones. | `number` | `3` | no |

#### Outputs

| Name | Description |
|------|-------------|
| <a name="output_compute_instance"></a> [compute_instance](#output_compute_instance) | Complete details of the compute instance(s) |
| <a name="output_compute_instances_by_zone"></a> [compute_instances_by_zone](#output_compute_instances_by_zone) | map of compute instance(s) keyed by zone |
| <a name="output_zones"></a> [zones](#output_zones) | Complete details of the compute instance(s) |
<!-- END_TF_DOCS -->
