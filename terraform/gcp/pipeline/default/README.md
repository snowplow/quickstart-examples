## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | ~> 1 |
| <a name="requirement_google"></a> [google](#requirement\_google) | ~> 3.44.0 |
| <a name="requirement_random"></a> [random](#requirement\_random) | ~> 3.1.0 |

## Providers

No providers.

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_bad_1_topic"></a> [bad\_1\_topic](#module\_bad\_1\_topic) | snowplow-devops/pubsub-topic/google | 0.1.0 |
| <a name="module_collector_lb"></a> [collector\_lb](#module\_collector\_lb) | snowplow-devops/lb/google | 0.1.0 |
| <a name="module_collector_pubsub"></a> [collector\_pubsub](#module\_collector\_pubsub) | snowplow-devops/collector-pubsub-ce/google | 0.2.2 |
| <a name="module_enrich_pubsub"></a> [enrich\_pubsub](#module\_enrich\_pubsub) | snowplow-devops/enrich-pubsub-ce/google | 0.1.2 |
| <a name="module_enriched_topic"></a> [enriched\_topic](#module\_enriched\_topic) | snowplow-devops/pubsub-topic/google | 0.1.0 |
| <a name="module_pipeline_db"></a> [pipeline\_db](#module\_pipeline\_db) | snowplow-devops/cloud-sql/google | 0.1.0 |
| <a name="module_postgres_loader_bad"></a> [postgres\_loader\_bad](#module\_postgres\_loader\_bad) | snowplow-devops/postgres-loader-pubsub-ce/google | 0.2.1 |
| <a name="module_postgres_loader_enriched"></a> [postgres\_loader\_enriched](#module\_postgres\_loader\_enriched) | snowplow-devops/postgres-loader-pubsub-ce/google | 0.2.1 |
| <a name="module_raw_topic"></a> [raw\_topic](#module\_raw\_topic) | snowplow-devops/pubsub-topic/google | 0.1.0 |

## Resources

No resources.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_iglu_server_dns_name"></a> [iglu\_server\_dns\_name](#input\_iglu\_server\_dns\_name) | The DNS name of your Iglu Server | `string` | n/a | yes |
| <a name="input_iglu_super_api_key"></a> [iglu\_super\_api\_key](#input\_iglu\_super\_api\_key) | A UUIDv4 string to use as the master API key for Iglu Server management | `string` | n/a | yes |
| <a name="input_network"></a> [network](#input\_network) | The name of the network to deploy within | `string` | n/a | yes |
| <a name="input_pipeline_db_name"></a> [pipeline\_db\_name](#input\_pipeline\_db\_name) | The name of the database to connect to | `string` | n/a | yes |
| <a name="input_pipeline_db_password"></a> [pipeline\_db\_password](#input\_pipeline\_db\_password) | The password to use to connect to the database | `string` | n/a | yes |
| <a name="input_pipeline_db_username"></a> [pipeline\_db\_username](#input\_pipeline\_db\_username) | The username to use to connect to the database | `string` | n/a | yes |
| <a name="input_prefix"></a> [prefix](#input\_prefix) | Will be prefixed to all resource names. Use to easily identify the resources created | `string` | n/a | yes |
| <a name="input_project_id"></a> [project\_id](#input\_project\_id) | The project ID in which the stack is being deployed | `string` | n/a | yes |
| <a name="input_region"></a> [region](#input\_region) | The name of the region to deploy within | `string` | n/a | yes |
| <a name="input_ssh_ip_allowlist"></a> [ssh\_ip\_allowlist](#input\_ssh\_ip\_allowlist) | The list of CIDR ranges to allow SSH traffic from | `list(any)` | n/a | yes |
| <a name="input_subnetwork"></a> [subnetwork](#input\_subnetwork) | The name of the sub-network to deploy within | `string` | n/a | yes |
| <a name="input_labels"></a> [labels](#input\_labels) | The labels to append to the resources in this module | `map(string)` | `{}` | no |
| <a name="input_pipeline_db_authorized_networks"></a> [pipeline\_db\_authorized\_networks](#input\_pipeline\_db\_authorized\_networks) | The list of CIDR ranges to allow access to the Pipeline Database over | <pre>list(object({<br>    name  = string<br>    value = string<br>  }))</pre> | `[]` | no |
| <a name="input_pipeline_db_tier"></a> [pipeline\_db\_tier](#input\_pipeline\_db\_tier) | The instance type to assign to the deployed Cloud SQL instance | `string` | `"db-g1-small"` | no |
| <a name="input_ssh_key_pairs"></a> [ssh\_key\_pairs](#input\_ssh\_key\_pairs) | The list of SSH key-pairs to add to the servers | <pre>list(object({<br>    user_name  = string<br>    public_key = string<br>  }))</pre> | `[]` | no |
| <a name="input_ssl_information"></a> [ssl\_information](#input\_ssl\_information) | The ID of an Google Managed certificate to bind to the load balancer | <pre>object({<br>    enabled        = bool<br>    certificate_id = string<br>  })</pre> | <pre>{<br>  "certificate_id": "",<br>  "enabled": false<br>}</pre> | no |
| <a name="input_telemetry_enabled"></a> [telemetry\_enabled](#input\_telemetry\_enabled) | Whether or not to send telemetry information back to Snowplow Analytics Ltd | `bool` | `true` | no |
| <a name="input_user_provided_id"></a> [user\_provided\_id](#input\_user\_provided\_id) | An optional unique identifier to identify the telemetry events emitted by this stack | `string` | `""` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_collector_ip_address"></a> [collector\_ip\_address](#output\_collector\_ip\_address) | The IP address for the Pipeline Collector |
| <a name="output_db_ip_address"></a> [db\_ip\_address](#output\_db\_ip\_address) | The IP address of the database where your data is being streamed |
| <a name="output_db_port"></a> [db\_port](#output\_db\_port) | The port of the database where your data is being streamed |