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
| <a name="module_bad_1_eh_topic"></a> [bad\_1\_eh\_topic](#module\_bad\_1\_eh\_topic) | snowplow-devops/event-hub/azurerm | 0.1.0 |
| <a name="module_collector_eh"></a> [collector\_eh](#module\_collector\_eh) | snowplow-devops/collector-event-hub-vmss/azurerm | 0.1.0 |
| <a name="module_collector_lb"></a> [collector\_lb](#module\_collector\_lb) | snowplow-devops/lb/azurerm | 0.1.0 |
| <a name="module_eh_namespace"></a> [eh\_namespace](#module\_eh\_namespace) | snowplow-devops/event-hub-namespace/azurerm | 0.1.0 |
| <a name="module_enrich_eh"></a> [enrich\_eh](#module\_enrich\_eh) | snowplow-devops/enrich-event-hub-vmss/azurerm | 0.1.0 |
| <a name="module_enriched_eh_topic"></a> [enriched\_eh\_topic](#module\_enriched\_eh\_topic) | snowplow-devops/event-hub/azurerm | 0.1.0 |
| <a name="module_raw_eh_topic"></a> [raw\_eh\_topic](#module\_raw\_eh\_topic) | snowplow-devops/event-hub/azurerm | 0.1.0 |

## Resources

No resources.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_prefix"></a> [prefix](#input\_prefix) | Will be prefixed to all resource names. Use to easily identify the resources created | `string` | n/a | yes |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | The name of the resource group to deploy resources within | `string` | n/a | yes |
| <a name="input_ssh_ip_allowlist"></a> [ssh\_ip\_allowlist](#input\_ssh\_ip\_allowlist) | The list of CIDR ranges to allow SSH traffic from | `list(any)` | n/a | yes |
| <a name="input_ssh_public_key"></a> [ssh\_public\_key](#input\_ssh\_public\_key) | The SSH public key to use for the deployment | `string` | n/a | yes |
| <a name="input_subnet_id_lb"></a> [subnet\_id\_lb](#input\_subnet\_id\_lb) | The ID of the subnet to deploy the load balancer into (e.g. collector-agw1) | `string` | n/a | yes |
| <a name="input_subnet_id_servers"></a> [subnet\_id\_servers](#input\_subnet\_id\_servers) | The ID of the subnet to deploy the servers into (e.g. pipeline1) | `string` | n/a | yes |
| <a name="input_ssl_information"></a> [ssl\_information](#input\_ssl\_information) | SSL certificate information to optionally bind to the load balancer | <pre>object({<br>    enabled  = bool<br>    data     = string<br>    password = string<br>  })</pre> | <pre>{<br>  "data": "",<br>  "enabled": false,<br>  "password": ""<br>}</pre> | no |
| <a name="input_tags"></a> [tags](#input\_tags) | The tags to append to the resources in this module | `map(string)` | `{}` | no |
| <a name="input_telemetry_enabled"></a> [telemetry\_enabled](#input\_telemetry\_enabled) | Whether or not to send telemetry information back to Snowplow Analytics Ltd | `bool` | `true` | no |
| <a name="input_user_provided_id"></a> [user\_provided\_id](#input\_user\_provided\_id) | An optional unique identifier to identify the telemetry events emitted by this stack | `string` | `""` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_collector_lb_fqdn"></a> [collector\_lb\_fqdn](#output\_collector\_lb\_fqdn) | The load balancers fully-qualified-domain-name for the Collector |
| <a name="output_collector_lb_ip_address"></a> [collector\_lb\_ip\_address](#output\_collector\_lb\_ip\_address) | The load balancers IP address for the Collector |
