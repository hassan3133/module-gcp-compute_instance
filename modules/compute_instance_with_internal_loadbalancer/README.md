## Compute Instance with Internal Loadbalancer
![Maintained by Priceline.com](https://img.shields.io/badge/maintained%20by-priceline.com-blue)
![Terraform Version](https://img.shields.io/badge/tf-%3E%3D0.13-blue.svg)

### Usage
<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 0.13 |

## Providers

No providers.

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_compute_instance"></a> [compute\_instance](#module\_compute\_instance) | ../compute_instance/ | n/a |
| <a name="module_compute_instance_group"></a> [compute\_instance\_group](#module\_compute\_instance\_group) | ../compute_instance_group/ | n/a |
| <a name="module_gcp_varlib"></a> [gcp\_varlib](#module\_gcp\_varlib) | git::https://github.com/pcln/terraform-gcp-varlib.git//modules/gcp_varlib | n/a |
| <a name="module_internal_loadbalancer"></a> [internal\_loadbalancer](#module\_internal\_loadbalancer) | git::https://github.com/pcln/terraform-gcp-internal_loadbalancer.git//modules/internal_loadbalancer_tfo/ | n/a |

## Resources

No resources.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_cell"></a> [cell](#input\_cell) | a priceline cell | `string` | n/a | yes |
| <a name="input_clusterid"></a> [clusterid](#input\_clusterid) | an alphabetic character representing the cluster | `string` | n/a | yes |
| <a name="input_data_disk_size"></a> [data\_disk\_size](#input\_data\_disk\_size) | Size of the persistent disk, specified in GB. | `number` | `null` | no |
| <a name="input_description"></a> [description](#input\_description) | the environment | `string` | `""` | no |
| <a name="input_disk_size"></a> [disk\_size](#input\_disk\_size) | Size of the persistent disk, specified in GB. You can specify this field when creating a persistent disk using the sourceImage or sourceSnapshot parameter, or specify it alone to create an empty persistent disk. If you specify this field along with sourceImage or sourceSnapshot, the value of sizeGb must not be less than the size of the sourceImage or the size of the snapshot. | `number` | n/a | yes |
| <a name="input_disk_type"></a> [disk\_type](#input\_disk\_type) | URL of the disk type resource describing which disk type to use to create the disk. Provide this when creating the disk. | `string` | `"pd-ssd"` | no |
| <a name="input_env"></a> [env](#input\_env) | the environment | `string` | n/a | yes |
| <a name="input_external_ips"></a> [external\_ips](#input\_external\_ips) | list of external compute instance ip address | `list(any)` | `[]` | no |
| <a name="input_health_check"></a> [health\_check](#input\_health\_check) | type of health check | `string` | `"tcp"` | no |
| <a name="input_health_check_port"></a> [health\_check\_port](#input\_health\_check\_port) | port health check checks against | `number` | `null` | no |
| <a name="input_image"></a> [image](#input\_image) | The name of a specific image.  When provided, it overrides the image\_family variable. | `string` | `""` | no |
| <a name="input_image_family"></a> [image\_family](#input\_image\_family) | The name of a specific image or a family.  It will returns the latest image that is part of an image family and is not deprecated. | `string` | `"pcln-base-centos7"` | no |
| <a name="input_internal_ips"></a> [internal\_ips](#input\_internal\_ips) | internal compute instance ip address type | `list(any)` | `[]` | no |
| <a name="input_ip_address"></a> [ip\_address](#input\_ip\_address) | internal load balancer ip address | `string` | `null` | no |
| <a name="input_labels"></a> [labels](#input\_labels) | A set of key/value label pairs to assign to the instance | `map(any)` | `{}` | no |
| <a name="input_machine_type"></a> [machine\_type](#input\_machine\_type) | The machine type to create<br>https://cloud.google.com/compute/docs/machine-types | `string` | `"n1-standard-1"` | no |
| <a name="input_metadata"></a> [metadata](#input\_metadata) | "Metadata key/value pairs to make available from within the instance. Ssh keys attached in the Cloud Console will be removed. Add them to your config in order to keep them attached to your instance" | `map(any)` | `{}` | no |
| <a name="input_module_count"></a> [module\_count](#input\_module\_count) | integer for the number of resources to create | `number` | `1` | no |
| <a name="input_ports"></a> [ports](#input\_ports) | the forwarding rule port range | `string` | n/a | yes |
| <a name="input_preemptible"></a> [preemptible](#input\_preemptible) | is the instance preemptible | `bool` | `false` | no |
| <a name="input_project"></a> [project](#input\_project) | The ID of the project in which the resource belongs. If it is not provided, the provider project is used. | `string` | n/a | yes |
| <a name="input_region"></a> [region](#input\_region) | a google cloud platform region | `string` | n/a | yes |
| <a name="input_servertype"></a> [servertype](#input\_servertype) | a priceline server type | `string` | n/a | yes |
| <a name="input_service_account"></a> [service\_account](#input\_service\_account) | a compute service account | `string` | `null` | no |
| <a name="input_service_label"></a> [service\_label](#input\_service\_label) | An optional prefix to the service name for this Forwarding Rule. If specified, will be the first label of the fully qualified service name. | `string` | `""` | no |
| <a name="input_session_affinity"></a> [session\_affinity](#input\_session\_affinity) | Type of session affinity to use. The default is NONE. Can be NONE, CLIENT\_IP, CLIENT\_IP\_PROTO, or CLIENT\_IP\_PORT\_PROTO. When the protocol is UDP, this field is not used | `string` | `"NONE"` | no |
| <a name="input_subnet_type"></a> [subnet\_type](#input\_subnet\_type) | a subnet type | `string` | `""` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | A list of tags to attach to the instance. | `list(any)` | `[]` | no |

## Outputs

No outputs.
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
