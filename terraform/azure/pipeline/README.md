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
| <a name="module_bad_1_eh_topic"></a> [bad\_1\_eh\_topic](#module\_bad\_1\_eh\_topic) | snowplow-devops/event-hub/azurerm | 0.1.1 |
| <a name="module_collector_eh"></a> [collector\_eh](#module\_collector\_eh) | snowplow-devops/collector-event-hub-vmss/azurerm | 0.1.1 |
| <a name="module_collector_lb"></a> [collector\_lb](#module\_collector\_lb) | snowplow-devops/lb/azurerm | 0.2.0 |
| <a name="module_eh_namespace"></a> [eh\_namespace](#module\_eh\_namespace) | snowplow-devops/event-hub-namespace/azurerm | 0.1.1 |
| <a name="module_enrich_eh"></a> [enrich\_eh](#module\_enrich\_eh) | snowplow-devops/enrich-event-hub-vmss/azurerm | 0.1.2 |
| <a name="module_enriched_eh_topic"></a> [enriched\_eh\_topic](#module\_enriched\_eh\_topic) | snowplow-devops/event-hub/azurerm | 0.1.1 |
| <a name="module_raw_eh_topic"></a> [raw\_eh\_topic](#module\_raw\_eh\_topic) | snowplow-devops/event-hub/azurerm | 0.1.1 |
| <a name="module_sf_loader"></a> [sf\_loader](#module\_sf\_loader) | snowplow-devops/snowflake-loader-vmss/azurerm | 0.1.1 |
| <a name="module_sf_message_queue_eh_topic"></a> [sf\_message\_queue\_eh\_topic](#module\_sf\_message\_queue\_eh\_topic) | snowplow-devops/event-hub/azurerm | 0.1.1 |
| <a name="module_sf_transformer_storage_container"></a> [sf\_transformer\_storage\_container](#module\_sf\_transformer\_storage\_container) | snowplow-devops/storage-container/azurerm | 0.1.1 |
| <a name="module_sf_transformer_wrj"></a> [sf\_transformer\_wrj](#module\_sf\_transformer\_wrj) | snowplow-devops/transformer-event-hub-vmss/azurerm | 0.1.1 |
| <a name="module_storage_account"></a> [storage\_account](#module\_storage\_account) | snowplow-devops/storage-account/azurerm | 0.1.2 |

## Resources

No resources.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_iglu_server_dns_name"></a> [iglu\_server\_dns\_name](#input\_iglu\_server\_dns\_name) | The DNS name of your Iglu Server | `string` | n/a | yes |
| <a name="input_iglu_super_api_key"></a> [iglu\_super\_api\_key](#input\_iglu\_super\_api\_key) | A UUIDv4 string to use as the master API key for Iglu Server management | `string` | n/a | yes |
| <a name="input_prefix"></a> [prefix](#input\_prefix) | Will be prefixed to all resource names. Use to easily identify the resources created | `string` | n/a | yes |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | The name of the resource group to deploy resources within | `string` | n/a | yes |
| <a name="input_ssh_ip_allowlist"></a> [ssh\_ip\_allowlist](#input\_ssh\_ip\_allowlist) | The list of CIDR ranges to allow SSH traffic from | `list(any)` | n/a | yes |
| <a name="input_ssh_public_key"></a> [ssh\_public\_key](#input\_ssh\_public\_key) | The SSH public key to use for the deployment | `string` | n/a | yes |
| <a name="input_storage_account_name"></a> [storage\_account\_name](#input\_storage\_account\_name) | The name of the Storage Account the data will be loaded into | `string` | n/a | yes |
| <a name="input_subnet_id_lb"></a> [subnet\_id\_lb](#input\_subnet\_id\_lb) | The ID of the subnet to deploy the load balancer into (e.g. collector-agw1) | `string` | n/a | yes |
| <a name="input_subnet_id_servers"></a> [subnet\_id\_servers](#input\_subnet\_id\_servers) | The ID of the subnet to deploy the servers into (e.g. pipeline1) | `string` | n/a | yes |
| <a name="input_snowflake_account"></a> [snowflake\_account](#input\_snowflake\_account) | Snowflake account to use | `string` | `""` | no |
| <a name="input_snowflake_database"></a> [snowflake\_database](#input\_snowflake\_database) | Snowflake database name | `string` | `""` | no |
| <a name="input_snowflake_enabled"></a> [snowflake\_enabled](#input\_snowflake\_enabled) | Whether to enable loading into a Snowflake Database | `bool` | `false` | no |
| <a name="input_snowflake_loader_password"></a> [snowflake\_loader\_password](#input\_snowflake\_loader\_password) | The password to use for the loader user | `string` | `""` | no |
| <a name="input_snowflake_loader_user"></a> [snowflake\_loader\_user](#input\_snowflake\_loader\_user) | The Snowflake user used by Snowflake Loader | `string` | `""` | no |
| <a name="input_snowflake_region"></a> [snowflake\_region](#input\_snowflake\_region) | Region of Snowflake account | `string` | `""` | no |
| <a name="input_snowflake_schema"></a> [snowflake\_schema](#input\_snowflake\_schema) | Snowflake schema name | `string` | `""` | no |
| <a name="input_snowflake_transformer_window_period_min"></a> [snowflake\_transformer\_window\_period\_min](#input\_snowflake\_transformer\_window\_period\_min) | Frequency to emit transforming finished message - 5,10,15,20,30,60 etc minutes | `number` | `5` | no |
| <a name="input_snowflake_warehouse"></a> [snowflake\_warehouse](#input\_snowflake\_warehouse) | Snowflake warehouse name | `string` | `""` | no |
| <a name="input_ssl_information"></a> [ssl\_information](#input\_ssl\_information) | SSL certificate information to optionally bind to the load balancer | <pre>object({<br>    enabled  = bool<br>    data     = string<br>    password = string<br>  })</pre> | <pre>{<br>  "data": "",<br>  "enabled": false,<br>  "password": ""<br>}</pre> | no |
| <a name="input_storage_account_deploy"></a> [storage\_account\_deploy](#input\_storage\_account\_deploy) | Whether this module should create a new storage account with the specified name - if the account already exists set this to false | `bool` | `true` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | The tags to append to the resources in this module | `map(string)` | `{}` | no |
| <a name="input_telemetry_enabled"></a> [telemetry\_enabled](#input\_telemetry\_enabled) | Whether or not to send telemetry information back to Snowplow Analytics Ltd | `bool` | `true` | no |
| <a name="input_user_provided_id"></a> [user\_provided\_id](#input\_user\_provided\_id) | An optional unique identifier to identify the telemetry events emitted by this stack | `string` | `""` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_collector_lb_fqdn"></a> [collector\_lb\_fqdn](#output\_collector\_lb\_fqdn) | The load balancers fully-qualified-domain-name for the Collector |
| <a name="output_collector_lb_ip_address"></a> [collector\_lb\_ip\_address](#output\_collector\_lb\_ip\_address) | The load balancers IP address for the Collector |
