## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.0.0 |
| <a name="requirement_google"></a> [google](#requirement\_google) | >= 3.90 |
| <a name="requirement_random"></a> [random](#requirement\_random) | >= 3 |

## Providers

No providers.

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_iglu_db"></a> [iglu\_db](#module\_iglu\_db) | snowplow-devops/cloud-sql/google | 0.3.0 |
| <a name="module_iglu_lb"></a> [iglu\_lb](#module\_iglu\_lb) | snowplow-devops/lb/google | 0.3.0 |
| <a name="module_iglu_server"></a> [iglu\_server](#module\_iglu\_server) | snowplow-devops/iglu-server-ce/google | 0.4.0 |

## Resources

No resources.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_iglu_db_name"></a> [iglu\_db\_name](#input\_iglu\_db\_name) | The name of the database to create | `string` | n/a | yes |
| <a name="input_iglu_db_password"></a> [iglu\_db\_password](#input\_iglu\_db\_password) | The password to use to connect to the database | `string` | n/a | yes |
| <a name="input_iglu_db_username"></a> [iglu\_db\_username](#input\_iglu\_db\_username) | The username to use to connect to the database | `string` | n/a | yes |
| <a name="input_iglu_super_api_key"></a> [iglu\_super\_api\_key](#input\_iglu\_super\_api\_key) | A UUIDv4 string to use as the master API key for Iglu Server management | `string` | n/a | yes |
| <a name="input_network"></a> [network](#input\_network) | The name of the network to deploy within | `string` | n/a | yes |
| <a name="input_prefix"></a> [prefix](#input\_prefix) | Will be prefixed to all resource names. Use to easily identify the resources created | `string` | n/a | yes |
| <a name="input_project_id"></a> [project\_id](#input\_project\_id) | The project ID in which the stack is being deployed | `string` | n/a | yes |
| <a name="input_region"></a> [region](#input\_region) | The name of the region to deploy within | `string` | n/a | yes |
| <a name="input_ssh_ip_allowlist"></a> [ssh\_ip\_allowlist](#input\_ssh\_ip\_allowlist) | The list of CIDR ranges to allow SSH traffic from | `list(any)` | n/a | yes |
| <a name="input_subnetwork"></a> [subnetwork](#input\_subnetwork) | The name of the sub-network to deploy within | `string` | n/a | yes |
| <a name="input_labels"></a> [labels](#input\_labels) | The labels to append to the resources in this module | `map(string)` | `{}` | no |
| <a name="input_ssh_key_pairs"></a> [ssh\_key\_pairs](#input\_ssh\_key\_pairs) | The list of SSH key-pairs to add to the servers | <pre>list(object({<br>    user_name  = string<br>    public_key = string<br>  }))</pre> | `[]` | no |
| <a name="input_ssl_information"></a> [ssl\_information](#input\_ssl\_information) | The ID of an Google Managed certificate to bind to the load balancer | <pre>object({<br>    enabled        = bool<br>    certificate_id = string<br>  })</pre> | <pre>{<br>  "certificate_id": "",<br>  "enabled": false<br>}</pre> | no |
| <a name="input_telemetry_enabled"></a> [telemetry\_enabled](#input\_telemetry\_enabled) | Whether or not to send telemetry information back to Snowplow Analytics Ltd | `bool` | `true` | no |
| <a name="input_user_provided_id"></a> [user\_provided\_id](#input\_user\_provided\_id) | An optional unique identifier to identify the telemetry events emitted by this stack | `string` | `""` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_iglu_server_ip_address"></a> [iglu\_server\_ip\_address](#output\_iglu\_server\_ip\_address) | The IP address for the Iglu Server |
