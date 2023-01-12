## Compute Instance
![Maintained by Priceline.com](https://img.shields.io/badge/maintained%20by-priceline.com-blue)
![Terraform Version](https://img.shields.io/badge/tf-%3E%3D0.13-blue.svg)

### Usage
<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 0.13 |
| <a name="requirement_google"></a> [google](#requirement\_google) | ~> 3.37 |
| <a name="requirement_google-beta"></a> [google-beta](#requirement\_google-beta) | >= 3.35 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_google"></a> [google](#provider\_google) | 3.90.1 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_cloudcost_labels"></a> [cloudcost\_labels](#module\_cloudcost\_labels) | git::https://github.com/pcln/terraform-curl-cloudcost_labels.git//modules/cloudcost_labels | n/a |
| <a name="module_gcp_varlib"></a> [gcp\_varlib](#module\_gcp\_varlib) | git::https://github.com/pcln/terraform-gcp-varlib.git//modules/gcp_varlib | n/a |

## Resources

| Name | Type |
|------|------|
| [google_compute_attached_disk.data](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_attached_disk) | resource |
| [google_compute_attached_disk.mdata](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_attached_disk) | resource |
| [google_compute_disk.data](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_disk) | resource |
| [google_compute_disk.mdata](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_disk) | resource |
| [google_compute_instance.default](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_instance) | resource |
| [google_compute_image.image_family](https://registry.terraform.io/providers/hashicorp/google/latest/docs/data-sources/compute_image) | data source |
| [google_compute_subnetwork.private](https://registry.terraform.io/providers/hashicorp/google/latest/docs/data-sources/compute_subnetwork) | data source |
| [google_compute_subnetwork.public](https://registry.terraform.io/providers/hashicorp/google/latest/docs/data-sources/compute_subnetwork) | data source |
| [google_compute_zones.available](https://registry.terraform.io/providers/hashicorp/google/latest/docs/data-sources/compute_zones) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_allow_stopping_for_update"></a> [allow\_stopping\_for\_update](#input\_allow\_stopping\_for\_update) | allow\_stopping\_for\_update | `bool` | `false` | no |
| <a name="input_boot_device_name"></a> [boot\_device\_name](#input\_boot\_device\_name) | Boot disk device name | `string` | `"boot"` | no |
| <a name="input_cell"></a> [cell](#input\_cell) | a priceline cell | `string` | n/a | yes |
| <a name="input_clusterid"></a> [clusterid](#input\_clusterid) | an alphabetic character representing the cluster | `string` | n/a | yes |
| <a name="input_data_disk_size"></a> [data\_disk\_size](#input\_data\_disk\_size) | Size of the persistent disk, specified in GB. | `number` | `null` | no |
| <a name="input_data_disk_size_map"></a> [data\_disk\_size\_map](#input\_data\_disk\_size\_map) | Map of specific data disk sizes to specific instance sequence numbers | `map(any)` | `{}` | no |
| <a name="input_data_labels"></a> [data\_labels](#input\_data\_labels) | A set of key/value label pairs to assign to the persistent disk. | `map(any)` | `{}` | no |
| <a name="input_deletion_protection"></a> [deletion\_protection](#input\_deletion\_protection) | Deletion Protection | `bool` | `true` | no |
| <a name="input_disable_scopes"></a> [disable\_scopes](#input\_disable\_scopes) | If set do not add service account block | `bool` | `false` | no |
| <a name="input_disk_size"></a> [disk\_size](#input\_disk\_size) | Size of the persistent disk, specified in GB. You can specify this field when creating a persistent disk using the sourceImage or sourceSnapshot parameter, or specify it alone to create an empty persistent disk. If you specify this field along with sourceImage or sourceSnapshot, the value of sizeGb must not be less than the size of the sourceImage or the size of the snapshot. | `number` | `32` | no |
| <a name="input_disk_size_map"></a> [disk\_size\_map](#input\_disk\_size\_map) | Map of specific disk sizes to specific instance sequence numbers | `map(any)` | `{}` | no |
| <a name="input_disk_type"></a> [disk\_type](#input\_disk\_type) | URL of the disk type resource describing which disk type to use to create the disk. Provide this when creating the disk. | `string` | `"pd-ssd"` | no |
| <a name="input_enable_display"></a> [enable\_display](#input\_enable\_display) | (Optional) Enable Virtual Displays on this instance. | `bool` | `false` | no |
| <a name="input_env"></a> [env](#input\_env) | the environment | `string` | n/a | yes |
| <a name="input_external_ips"></a> [external\_ips](#input\_external\_ips) | list of external compute instance ip address - put blank array elements '' for ephemeral ips. ONLY hardcoat static reserved IP's | `list(any)` | `[]` | no |
| <a name="input_health_check"></a> [health\_check](#input\_health\_check) | type of health check | `string` | `"tcp"` | no |
| <a name="input_health_check_port"></a> [health\_check\_port](#input\_health\_check\_port) | port health check checks against | `number` | `null` | no |
| <a name="input_image"></a> [image](#input\_image) | The name of a specific image.  When provided, it overrides the image\_family variable. | `string` | `""` | no |
| <a name="input_image_family"></a> [image\_family](#input\_image\_family) | The name of a specific image or a family.  It will returns the latest image that is part of an image family and is not deprecated. | `string` | `"pcln-base-centos7"` | no |
| <a name="input_image_family_project"></a> [image\_family\_project](#input\_image\_family\_project) | The name of a specific custom project to get images from. | `string` | `""` | no |
| <a name="input_image_map"></a> [image\_map](#input\_image\_map) | Map of specific images to specific instance sequence numbers | `map(any)` | `{}` | no |
| <a name="input_internal_ips"></a> [internal\_ips](#input\_internal\_ips) | internal compute instance ip address type | `list(any)` | `[]` | no |
| <a name="input_labels"></a> [labels](#input\_labels) | A set of key/value label pairs to assign to the instance | `map(any)` | `{}` | no |
| <a name="input_machine_type"></a> [machine\_type](#input\_machine\_type) | The machine type to create<br>https://cloud.google.com/compute/docs/machine-types | `string` | `"n1-standard-1"` | no |
| <a name="input_managed_by_sheriff"></a> [managed\_by\_sheriff](#input\_managed\_by\_sheriff) | If set adds the dns, inventory and ansible labels to the instance, default behaviour is to add the sheriff labels | `bool` | `true` | no |
| <a name="input_metadata"></a> [metadata](#input\_metadata) | "Metadata key/value pairs to make available from within the instance. Ssh keys attached in the Cloud Console will be removed. Add them to your config in order to keep them attached to your instance" | `map(any)` | `{}` | no |
| <a name="input_min_cpu_platform"></a> [min\_cpu\_platform](#input\_min\_cpu\_platform) | CPU platform for the instance, e.g. Broadwell or Haswell | `string` | `""` | no |
| <a name="input_module_count"></a> [module\_count](#input\_module\_count) | integer for the number of resources to create | `number` | `1` | no |
| <a name="input_multiple_data_disks"></a> [multiple\_data\_disks](#input\_multiple\_data\_disks) | Sizes of the persistent disks per instance, specified in GB. | `list(number)` | `[]` | no |
| <a name="input_network_name_override"></a> [network\_name\_override](#input\_network\_name\_override) | Override the network name | `string` | `""` | no |
| <a name="input_network_project_override"></a> [network\_project\_override](#input\_network\_project\_override) | Override the network name | `string` | `""` | no |
| <a name="input_network_type"></a> [network\_type](#input\_network\_type) | used to identify the network | `string` | `"net"` | no |
| <a name="input_no_default_tags"></a> [no\_default\_tags](#input\_no\_default\_tags) | If set only the tags passed in from the calling module are added to the instance | `bool` | `false` | no |
| <a name="input_palo_proxy_enabled"></a> [palo\_proxy\_enabled](#input\_palo\_proxy\_enabled) | Enable transparent proxy | `bool` | `true` | no |
| <a name="input_preemptible"></a> [preemptible](#input\_preemptible) | is the instance preemptible | `bool` | `false` | no |
| <a name="input_project"></a> [project](#input\_project) | The ID of the project in which the resource belongs. If it is not provided, the provider project is used. | `string` | n/a | yes |
| <a name="input_region"></a> [region](#input\_region) | a google cloud platform region | `string` | n/a | yes |
| <a name="input_resource_policies"></a> [resource\_policies](#input\_resource\_policies) | A list of resource policies to attach to the instance. | `list(any)` | `[]` | no |
| <a name="input_resource_policies_instance_count"></a> [resource\_policies\_instance\_count](#input\_resource\_policies\_instance\_count) | A number of instances to which a resource policy will be applied. If there 10 instances and this var is set to 5, 5 instances will have the policy attached and 5 won't | `number` | `1000` | no |
| <a name="input_scopes"></a> [scopes](#input\_scopes) | If set does not add scopes to service account block | `list(string)` | <pre>[<br>  "cloud-platform"<br>]</pre> | no |
| <a name="input_sequence_to_start_with"></a> [sequence\_to\_start\_with](#input\_sequence\_to\_start\_with) | sequence number to assign to a name of the first instance of servertype set, default is 1 | `number` | `1` | no |
| <a name="input_servertype"></a> [servertype](#input\_servertype) | a priceline server type | `string` | n/a | yes |
| <a name="input_service_account"></a> [service\_account](#input\_service\_account) | a compute service account | `string` | `null` | no |
| <a name="input_session_affinity"></a> [session\_affinity](#input\_session\_affinity) | Type of session affinity to use. The default is NONE. Can be NONE, CLIENT\_IP, CLIENT\_IP\_PROTO, or CLIENT\_IP\_PORT\_PROTO. When the protocol is UDP, this field is not used | `string` | `"NONE"` | no |
| <a name="input_shielded_instance_config"></a> [shielded\_instance\_config](#input\_shielded\_instance\_config) | shielded\_instance\_config settings | `map(any)` | `{}` | no |
| <a name="input_subnet_type"></a> [subnet\_type](#input\_subnet\_type) | a subnet type | `string` | n/a | yes |
| <a name="input_tags"></a> [tags](#input\_tags) | A list of tags to attach to the instance. | `list(any)` | `[]` | no |
| <a name="input_team"></a> [team](#input\_team) | Name of the team that owns the instance | `string` | `""` | no |
| <a name="input_zone_to_start_with"></a> [zone\_to\_start\_with](#input\_zone\_to\_start\_with) | zone to assign to first instance of servertype set, default is b | `number` | `1` | no |
| <a name="input_zones_limit"></a> [zones\_limit](#input\_zones\_limit) | Limit number of zones. | `number` | `3` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_compute_instance"></a> [compute\_instance](#output\_compute\_instance) | Complete details of the compute instance(s) |
| <a name="output_compute_instances_by_zone"></a> [compute\_instances\_by\_zone](#output\_compute\_instances\_by\_zone) | map of compute instance(s) keyed by zone |
| <a name="output_zones"></a> [zones](#output\_zones) | Complete details of the compute instance(s) |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
