## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.0.0 |
| <a name="requirement_google"></a> [google](#requirement\_google) | >= 6 |
| <a name="requirement_random"></a> [random](#requirement\_random) | >= 3 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_google"></a> [google](#provider\_google) | 6.39.0 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_bad_1_topic"></a> [bad\_1\_topic](#module\_bad\_1\_topic) | snowplow-devops/pubsub-topic/google | 0.3.0 |
| <a name="module_bigquery_loader"></a> [bigquery\_loader](#module\_bigquery\_loader) | snowplow-devops/bigquery-loader-pubsub-ce/google | 0.5.0 |
| <a name="module_bq_bad_rows_topic"></a> [bq\_bad\_rows\_topic](#module\_bq\_bad\_rows\_topic) | snowplow-devops/pubsub-topic/google | 0.3.0 |
| <a name="module_collector_lb"></a> [collector\_lb](#module\_collector\_lb) | snowplow-devops/lb/google | 0.3.0 |
| <a name="module_collector_pubsub"></a> [collector\_pubsub](#module\_collector\_pubsub) | snowplow-devops/collector-pubsub-ce/google | 0.7.0 |
| <a name="module_enrich_pubsub"></a> [enrich\_pubsub](#module\_enrich\_pubsub) | snowplow-devops/enrich-pubsub-ce/google | 0.5.0 |
| <a name="module_enriched_topic"></a> [enriched\_topic](#module\_enriched\_topic) | snowplow-devops/pubsub-topic/google | 0.3.0 |
| <a name="module_raw_topic"></a> [raw\_topic](#module\_raw\_topic) | snowplow-devops/pubsub-topic/google | 0.3.0 |

## Resources

| Name | Type |
|------|------|
| [google_bigquery_dataset.bigquery_db](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/bigquery_dataset) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_iglu_server_dns_name"></a> [iglu\_server\_dns\_name](#input\_iglu\_server\_dns\_name) | The DNS name of your Iglu Server | `string` | n/a | yes |
| <a name="input_iglu_super_api_key"></a> [iglu\_super\_api\_key](#input\_iglu\_super\_api\_key) | A UUIDv4 string to use as the master API key for Iglu Server management | `string` | n/a | yes |
| <a name="input_network"></a> [network](#input\_network) | The name of the network to deploy within | `string` | n/a | yes |
| <a name="input_prefix"></a> [prefix](#input\_prefix) | Will be prefixed to all resource names. Use to easily identify the resources created | `string` | n/a | yes |
| <a name="input_project_id"></a> [project\_id](#input\_project\_id) | The project ID in which the stack is being deployed | `string` | n/a | yes |
| <a name="input_region"></a> [region](#input\_region) | The name of the region to deploy within | `string` | n/a | yes |
| <a name="input_ssh_ip_allowlist"></a> [ssh\_ip\_allowlist](#input\_ssh\_ip\_allowlist) | The list of CIDR ranges to allow SSH traffic from | `list(any)` | n/a | yes |
| <a name="input_subnetwork"></a> [subnetwork](#input\_subnetwork) | The name of the sub-network to deploy within | `string` | n/a | yes |
| <a name="input_accept_limited_use_license"></a> [accept\_limited\_use\_license](#input\_accept\_limited\_use\_license) | Acceptance of the SLULA terms (https://docs.snowplow.io/limited-use-license-1.0/) | `bool` | `false` | no |
| <a name="input_bigquery_db_enabled"></a> [bigquery\_db\_enabled](#input\_bigquery\_db\_enabled) | Whether to enable loading into a BigQuery Dataset | `bool` | `false` | no |
| <a name="input_labels"></a> [labels](#input\_labels) | The labels to append to the resources in this module | `map(string)` | `{}` | no |
| <a name="input_ssh_key_pairs"></a> [ssh\_key\_pairs](#input\_ssh\_key\_pairs) | The list of SSH key-pairs to add to the servers | <pre>list(object({<br/>    user_name  = string<br/>    public_key = string<br/>  }))</pre> | `[]` | no |
| <a name="input_ssl_information"></a> [ssl\_information](#input\_ssl\_information) | The ID of an Google Managed certificate to bind to the load balancer | <pre>object({<br/>    enabled        = bool<br/>    certificate_id = string<br/>  })</pre> | <pre>{<br/>  "certificate_id": "",<br/>  "enabled": false<br/>}</pre> | no |
| <a name="input_telemetry_enabled"></a> [telemetry\_enabled](#input\_telemetry\_enabled) | Whether or not to send telemetry information back to Snowplow Analytics Ltd | `bool` | `true` | no |
| <a name="input_user_provided_id"></a> [user\_provided\_id](#input\_user\_provided\_id) | An optional unique identifier to identify the telemetry events emitted by this stack | `string` | `""` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_bigquery_db_dataset_id"></a> [bigquery\_db\_dataset\_id](#output\_bigquery\_db\_dataset\_id) | The ID of the BigQuery dataset where your data is being streamed |
| <a name="output_bq_loader_bad_rows_topic_name"></a> [bq\_loader\_bad\_rows\_topic\_name](#output\_bq\_loader\_bad\_rows\_topic\_name) | The name of the topic for bad rows emitted from the BigQuery loader |
| <a name="output_collector_ip_address"></a> [collector\_ip\_address](#output\_collector\_ip\_address) | The IP address for the Pipeline Collector |
