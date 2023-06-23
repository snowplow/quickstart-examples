## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.0.0 |
| <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm) | >= 3.58.0 |

## Providers

No providers.

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_iglu_db"></a> [iglu\_db](#module\_iglu\_db) | snowplow-devops/postgresql-server/azurerm | 0.1.1 |
| <a name="module_iglu_lb"></a> [iglu\_lb](#module\_iglu\_lb) | snowplow-devops/lb/azurerm | 0.1.1 |
| <a name="module_iglu_server"></a> [iglu\_server](#module\_iglu\_server) | snowplow-devops/iglu-server-vmss/azurerm | 0.1.1 |

## Resources

No resources.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_iglu_db_name"></a> [iglu\_db\_name](#input\_iglu\_db\_name) | The name of the database to create | `string` | n/a | yes |
| <a name="input_iglu_db_password"></a> [iglu\_db\_password](#input\_iglu\_db\_password) | The password to use to connect to the database | `string` | n/a | yes |
| <a name="input_iglu_db_username"></a> [iglu\_db\_username](#input\_iglu\_db\_username) | The username to use to connect to the database | `string` | n/a | yes |
| <a name="input_iglu_super_api_key"></a> [iglu\_super\_api\_key](#input\_iglu\_super\_api\_key) | A UUIDv4 string to use as the master API key for Iglu Server management | `string` | n/a | yes |
| <a name="input_prefix"></a> [prefix](#input\_prefix) | Will be prefixed to all resource names. Use to easily identify the resources created | `string` | n/a | yes |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | The name of the resource group to deploy resources within | `string` | n/a | yes |
| <a name="input_ssh_ip_allowlist"></a> [ssh\_ip\_allowlist](#input\_ssh\_ip\_allowlist) | The list of CIDR ranges to allow SSH traffic from | `list(any)` | n/a | yes |
| <a name="input_ssh_public_key"></a> [ssh\_public\_key](#input\_ssh\_public\_key) | The SSH public key to use for the deployment | `string` | n/a | yes |
| <a name="input_subnet_id_lb"></a> [subnet\_id\_lb](#input\_subnet\_id\_lb) | The ID of the subnet to deploy the load balancer into (e.g. iglu-agw1) | `string` | n/a | yes |
| <a name="input_subnet_id_servers"></a> [subnet\_id\_servers](#input\_subnet\_id\_servers) | The ID of the subnet to deploy the servers into (e.g. iglu1) | `string` | n/a | yes |
| <a name="input_iglu_db_ip_allowlist"></a> [iglu\_db\_ip\_allowlist](#input\_iglu\_db\_ip\_allowlist) | An optional list of CIDR ranges to allow traffic from | `list(any)` | `[]` | no |
| <a name="input_ssl_information"></a> [ssl\_information](#input\_ssl\_information) | SSL certificate information to optionally bind to the load balancer | <pre>object({<br>    enabled  = bool<br>    data     = string<br>    password = string<br>  })</pre> | <pre>{<br>  "data": "",<br>  "enabled": false,<br>  "password": ""<br>}</pre> | no |
| <a name="input_tags"></a> [tags](#input\_tags) | The tags to append to the resources in this module | `map(string)` | `{}` | no |
| <a name="input_telemetry_enabled"></a> [telemetry\_enabled](#input\_telemetry\_enabled) | Whether or not to send telemetry information back to Snowplow Analytics Ltd | `bool` | `true` | no |
| <a name="input_user_provided_id"></a> [user\_provided\_id](#input\_user\_provided\_id) | An optional unique identifier to identify the telemetry events emitted by this stack | `string` | `""` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_iglu_server_lb_fqdn"></a> [iglu\_server\_lb\_fqdn](#output\_iglu\_server\_lb\_fqdn) | The load balancers fully-qualified-domain-name for the Iglu Server |
| <a name="output_iglu_server_lb_ip_address"></a> [iglu\_server\_lb\_ip\_address](#output\_iglu\_server\_lb\_ip\_address) | The load balancers IP address for the Iglu Server |
