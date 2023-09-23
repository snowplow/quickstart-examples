## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | ~> 1 |
| <a name="requirement_google"></a> [google](#requirement\_google) | ~> 3.90.1 |
| <a name="requirement_random"></a> [random](#requirement\_random) | ~> 3.1.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_google"></a> [google](#provider\_google) | ~> 3.90.1 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_bad_1_topic"></a> [bad\_1\_topic](#module\_bad\_1\_topic) | snowplow-devops/pubsub-topic/google | 0.1.0 |
| <a name="module_bad_rows_topic"></a> [bad\_rows\_topic](#module\_bad\_rows\_topic) | snowplow-devops/pubsub-topic/google | 0.1.0 |
| <a name="module_bigquery_loader"></a> [bigquery\_loader](#module\_bigquery\_loader) | snowplow-devops/bigquery-loader-pubsub-ce/google | 0.1.0 |
| <a name="module_collector_lb"></a> [collector\_lb](#module\_collector\_lb) | snowplow-devops/lb/google | 0.1.0 |
| <a name="module_collector_pubsub"></a> [collector\_pubsub](#module\_collector\_pubsub) | snowplow-devops/collector-pubsub-ce/google | 0.2.2 |
| <a name="module_databricks_loader"></a> [databricks\_loader](#module\_databricks\_loader) | ../../../../../terraform-google-databricks-loader-pubsub-ce | n/a |
| <a name="module_enrich_pubsub"></a> [enrich\_pubsub](#module\_enrich\_pubsub) | snowplow-devops/enrich-pubsub-ce/google | 0.1.2 |
| <a name="module_enriched_topic"></a> [enriched\_topic](#module\_enriched\_topic) | snowplow-devops/pubsub-topic/google | 0.1.0 |
| <a name="module_postgres_db"></a> [postgres\_db](#module\_postgres\_db) | snowplow-devops/cloud-sql/google | 0.1.1 |
| <a name="module_postgres_loader_bad"></a> [postgres\_loader\_bad](#module\_postgres\_loader\_bad) | snowplow-devops/postgres-loader-pubsub-ce/google | 0.2.1 |
| <a name="module_postgres_loader_enriched"></a> [postgres\_loader\_enriched](#module\_postgres\_loader\_enriched) | snowplow-devops/postgres-loader-pubsub-ce/google | 0.2.1 |
| <a name="module_raw_topic"></a> [raw\_topic](#module\_raw\_topic) | snowplow-devops/pubsub-topic/google | 0.1.0 |
| <a name="module_snowflake_loader"></a> [snowflake\_loader](#module\_snowflake\_loader) | ../../../../../terraform-google-snowflake-loader-pubsub-ce | n/a |
| <a name="module_transformed_topic"></a> [transformed\_topic](#module\_transformed\_topic) | snowplow-devops/pubsub-topic/google | 0.1.0 |
| <a name="module_transformer_pubsub_enriched"></a> [transformer\_pubsub\_enriched](#module\_transformer\_pubsub\_enriched) | ../../../../../terraform-google-transformer-pubsub-ce | n/a |

## Resources

| Name | Type |
|------|------|
| [google_bigquery_dataset.bigquery_db](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/bigquery_dataset) | resource |
| [google_storage_bucket.bq_loader_dead_letter_bucket](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/storage_bucket) | resource |
| [google_storage_bucket.transformer_bucket](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/storage_bucket) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_bigquery_db_enabled"></a> [bigquery\_db\_enabled](#input\_bigquery\_db\_enabled) | Whether to enable loading into a BigQuery Dataset | `bool` | `false` | no |
| <a name="input_bigquery_loader_dead_letter_bucket_deploy"></a> [bigquery\_loader\_dead\_letter\_bucket\_deploy](#input\_bigquery\_loader\_dead\_letter\_bucket\_deploy) | Whether this module should create a new bucket with the specified name - if the bucket already exists set this to false | `bool` | `true` | no |
| <a name="input_bigquery_loader_dead_letter_bucket_name"></a> [bigquery\_loader\_dead\_letter\_bucket\_name](#input\_bigquery\_loader\_dead\_letter\_bucket\_name) | The name of the GCS bucket to use for dead-letter output of loader | `string` | `""` | no |
| <a name="input_databricks_callback_iam"></a> [databricks\_callback\_iam](#input\_databricks\_callback\_iam) | Databricks callback IAM to allow access to GCS bucket | `string` | n/a | yes |
| <a name="input_deltalake_auth_token"></a> [deltalake\_auth\_token](#input\_deltalake\_auth\_token) | Databricks deltalake auth token | `string` | `""` | no |
| <a name="input_deltalake_catalog"></a> [deltalake\_catalog](#input\_deltalake\_catalog) | Databricks deltalake catalog | `string` | `"hive_metastore"` | no |
| <a name="input_deltalake_host"></a> [deltalake\_host](#input\_deltalake\_host) | Databricks deltalake host | `string` | `""` | no |
| <a name="input_deltalake_http_path"></a> [deltalake\_http\_path](#input\_deltalake\_http\_path) | Databricks deltalake http path | `string` | `""` | no |
| <a name="input_deltalake_port"></a> [deltalake\_port](#input\_deltalake\_port) | Databricks deltalake port | `string` | `""` | no |
| <a name="input_deltalake_schema"></a> [deltalake\_schema](#input\_deltalake\_schema) | Databricks deltalake schema | `string` | `""` | no |
| <a name="input_iglu_server_dns_name"></a> [iglu\_server\_dns\_name](#input\_iglu\_server\_dns\_name) | The DNS name of your Iglu Server | `string` | n/a | yes |
| <a name="input_iglu_super_api_key"></a> [iglu\_super\_api\_key](#input\_iglu\_super\_api\_key) | A UUIDv4 string to use as the master API key for Iglu Server management | `string` | n/a | yes |
| <a name="input_labels"></a> [labels](#input\_labels) | The labels to append to the resources in this module | `map(string)` | `{}` | no |
| <a name="input_network"></a> [network](#input\_network) | The name of the network to deploy within | `string` | n/a | yes |
| <a name="input_postgres_db_authorized_networks"></a> [postgres\_db\_authorized\_networks](#input\_postgres\_db\_authorized\_networks) | The list of CIDR ranges to allow access to the Pipeline Database over | <pre>list(object({<br>    name  = string<br>    value = string<br>  }))</pre> | `[]` | no |
| <a name="input_postgres_db_enabled"></a> [postgres\_db\_enabled](#input\_postgres\_db\_enabled) | Whether to enable loading into a Postgres Database | `bool` | `false` | no |
| <a name="input_postgres_db_name"></a> [postgres\_db\_name](#input\_postgres\_db\_name) | The name of the database to connect to | `string` | n/a | yes |
| <a name="input_postgres_db_password"></a> [postgres\_db\_password](#input\_postgres\_db\_password) | The password to use to connect to the database | `string` | n/a | yes |
| <a name="input_postgres_db_tier"></a> [postgres\_db\_tier](#input\_postgres\_db\_tier) | The instance type to assign to the deployed Cloud SQL instance | `string` | `"db-g1-small"` | no |
| <a name="input_postgres_db_username"></a> [postgres\_db\_username](#input\_postgres\_db\_username) | The username to use to connect to the database | `string` | n/a | yes |
| <a name="input_prefix"></a> [prefix](#input\_prefix) | Will be prefixed to all resource names. Use to easily identify the resources created | `string` | n/a | yes |
| <a name="input_project_id"></a> [project\_id](#input\_project\_id) | The project ID in which the stack is being deployed | `string` | n/a | yes |
| <a name="input_region"></a> [region](#input\_region) | The name of the region to deploy within | `string` | n/a | yes |
| <a name="input_snowflake_account"></a> [snowflake\_account](#input\_snowflake\_account) | Snowflake account to use | `string` | `""` | no |
| <a name="input_snowflake_callback_iam"></a> [snowflake\_callback\_iam](#input\_snowflake\_callback\_iam) | Snowflake callback IAM from STORAGE INTEGRATION | `string` | `""` | no |
| <a name="input_snowflake_database"></a> [snowflake\_database](#input\_snowflake\_database) | Snowflake database name | `string` | `""` | no |
| <a name="input_snowflake_loader_password"></a> [snowflake\_loader\_password](#input\_snowflake\_loader\_password) | The password to use for the loader user | `string` | `""` | no |
| <a name="input_snowflake_loader_role"></a> [snowflake\_loader\_role](#input\_snowflake\_loader\_role) | Snowflake role for loading snowplow data | `string` | `""` | no |
| <a name="input_snowflake_loader_user"></a> [snowflake\_loader\_user](#input\_snowflake\_loader\_user) | The Snowflake user used by Snowflake Loader | `string` | `""` | no |
| <a name="input_snowflake_region"></a> [snowflake\_region](#input\_snowflake\_region) | Region of Snowflake account | `string` | `""` | no |
| <a name="input_snowflake_schema"></a> [snowflake\_schema](#input\_snowflake\_schema) | Snowflake schema name | `string` | `""` | no |
| <a name="input_snowflake_transformed_stage_name"></a> [snowflake\_transformed\_stage\_name](#input\_snowflake\_transformed\_stage\_name) | Name of transformed stage | `string` | `""` | no |
| <a name="input_snowflake_warehouse"></a> [snowflake\_warehouse](#input\_snowflake\_warehouse) | Snowflake warehouse name | `string` | `""` | no |
| <a name="input_ssh_ip_allowlist"></a> [ssh\_ip\_allowlist](#input\_ssh\_ip\_allowlist) | The list of CIDR ranges to allow SSH traffic from | `list(any)` | n/a | yes |
| <a name="input_ssh_key_pairs"></a> [ssh\_key\_pairs](#input\_ssh\_key\_pairs) | The list of SSH key-pairs to add to the servers | <pre>list(object({<br>    user_name  = string<br>    public_key = string<br>  }))</pre> | `[]` | no |
| <a name="input_ssl_information"></a> [ssl\_information](#input\_ssl\_information) | The ID of an Google Managed certificate to bind to the load balancer | <pre>object({<br>    enabled        = bool<br>    certificate_id = string<br>  })</pre> | <pre>{<br>  "certificate_id": "",<br>  "enabled": false<br>}</pre> | no |
| <a name="input_subnetwork"></a> [subnetwork](#input\_subnetwork) | The name of the sub-network to deploy within | `string` | n/a | yes |
| <a name="input_telemetry_enabled"></a> [telemetry\_enabled](#input\_telemetry\_enabled) | Whether or not to send telemetry information back to Snowplow Analytics Ltd | `bool` | `true` | no |
| <a name="input_transformer_bucket_name"></a> [transformer\_bucket\_name](#input\_transformer\_bucket\_name) | Transformer bucket name, prefixed with the prefix value | `string` | `"qs-transformed"` | no |
| <a name="input_transformer_window_period_min"></a> [transformer\_window\_period\_min](#input\_transformer\_window\_period\_min) | Frequency to emit transforming finished message - 5,10,15,20,30,60 etc minutes | `number` | `5` | no |
| <a name="input_user_provided_id"></a> [user\_provided\_id](#input\_user\_provided\_id) | An optional unique identifier to identify the telemetry events emitted by this stack | `string` | `""` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_bigquery_db_dataset_id"></a> [bigquery\_db\_dataset\_id](#output\_bigquery\_db\_dataset\_id) | The ID of the BigQuery dataset where your data is being streamed |
| <a name="output_bq_loader_bad_rows_topic_name"></a> [bq\_loader\_bad\_rows\_topic\_name](#output\_bq\_loader\_bad\_rows\_topic\_name) | The name of the topic for bad rows emitted from the BigQuery loader |
| <a name="output_bq_loader_dead_letter_bucket_name"></a> [bq\_loader\_dead\_letter\_bucket\_name](#output\_bq\_loader\_dead\_letter\_bucket\_name) | The name of the GCS bucket for dead letter events emitted from the BigQuery loader |
| <a name="output_collector_ip_address"></a> [collector\_ip\_address](#output\_collector\_ip\_address) | The IP address for the Pipeline Collector |
| <a name="output_postgres_db_ip_address"></a> [postgres\_db\_ip\_address](#output\_postgres\_db\_ip\_address) | The IP address of the database where your data is being streamed |
| <a name="output_postgres_db_port"></a> [postgres\_db\_port](#output\_postgres\_db\_port) | The port of the database where your data is being streamed |
