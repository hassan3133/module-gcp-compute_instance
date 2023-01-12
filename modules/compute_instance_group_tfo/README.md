## Compute Instance Group
![Maintained by Priceline.com](https://img.shields.io/badge/maintained%20by-priceline.com-blue)
![Terraform Version](https://img.shields.io/badge/tf-%3E%3D0.13-blue.svg)

### Usage
<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 0.13 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_google"></a> [google](#provider\_google) | n/a |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_gcp_varlib"></a> [gcp\_varlib](#module\_gcp\_varlib) | git::https://github.com/pcln/terraform-gcp-varlib.git//modules/gcp_varlib | n/a |

## Resources

| Name | Type |
|------|------|
| [google_compute_instance_group.default](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_instance_group) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_clusterid"></a> [clusterid](#input\_clusterid) | an alphabetic character representing the cluster | `string` | n/a | yes |
| <a name="input_compute_instances_by_zone"></a> [compute\_instances\_by\_zone](#input\_compute\_instances\_by\_zone) | map of compute instance self\_links by zone | `map(any)` | n/a | yes |
| <a name="input_create_before_destroy"></a> [create\_before\_destroy](#input\_create\_before\_destroy) | create before destroy lifecycle | `bool` | `false` | no |
| <a name="input_env"></a> [env](#input\_env) | the environment | `string` | n/a | yes |
| <a name="input_named_ports"></a> [named\_ports](#input\_named\_ports) | n/a | <pre>list(object({<br>    name = string<br>    port = number<br>  }))</pre> | <pre>[<br>  {<br>    "name": "https",<br>    "port": 443<br>  }<br>]</pre> | no |
| <a name="input_project"></a> [project](#input\_project) | The ID of the project in which the resource belongs. If it is not provided, the provider project is used. | `string` | n/a | yes |
| <a name="input_region"></a> [region](#input\_region) | a google cloud platform region | `string` | n/a | yes |
| <a name="input_servertype"></a> [servertype](#input\_servertype) | a priceline server type | `string` | n/a | yes |
| <a name="input_zone_to_start_with"></a> [zone\_to\_start\_with](#input\_zone\_to\_start\_with) | start with this zone | `number` | `0` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_self_links"></a> [self\_links](#output\_self\_links) | self link to generated compute instance group |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
