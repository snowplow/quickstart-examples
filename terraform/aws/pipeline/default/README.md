## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | ~> 1 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | ~> 3.72.0 |
| <a name="requirement_random"></a> [random](#requirement\_random) | ~> 3.1.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | 3.72.0 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_bad_1_stream"></a> [bad\_1\_stream](#module\_bad\_1\_stream) | snowplow-devops/kinesis-stream/aws | 0.1.1 |
| <a name="module_bad_2_stream"></a> [bad\_2\_stream](#module\_bad\_2\_stream) | snowplow-devops/kinesis-stream/aws | 0.1.1 |
| <a name="module_collector_kinesis"></a> [collector\_kinesis](#module\_collector\_kinesis) | snowplow-devops/collector-kinesis-ec2/aws | 0.2.1 |
| <a name="module_collector_lb"></a> [collector\_lb](#module\_collector\_lb) | snowplow-devops/alb/aws | 0.1.2 |
| <a name="module_databricks_loader"></a> [databricks\_loader](#module\_databricks\_loader) | snowplow-devops/databricks-loader-ec2/aws | 0.1.0 |
| <a name="module_enrich_kinesis"></a> [enrich\_kinesis](#module\_enrich\_kinesis) | snowplow-devops/enrich-kinesis-ec2/aws | 0.2.1 |
| <a name="module_enriched_stream"></a> [enriched\_stream](#module\_enriched\_stream) | snowplow-devops/kinesis-stream/aws | 0.1.1 |
| <a name="module_pipeline_rds"></a> [pipeline\_rds](#module\_pipeline\_rds) | snowplow-devops/rds/aws | 0.1.4 |
| <a name="module_postgres_loader_bad"></a> [postgres\_loader\_bad](#module\_postgres\_loader\_bad) | snowplow-devops/postgres-loader-kinesis-ec2/aws | 0.2.0 |
| <a name="module_postgres_loader_enriched"></a> [postgres\_loader\_enriched](#module\_postgres\_loader\_enriched) | snowplow-devops/postgres-loader-kinesis-ec2/aws | 0.2.0 |
| <a name="module_raw_stream"></a> [raw\_stream](#module\_raw\_stream) | snowplow-devops/kinesis-stream/aws | 0.1.1 |
| <a name="module_s3_loader_bad"></a> [s3\_loader\_bad](#module\_s3\_loader\_bad) | snowplow-devops/s3-loader-kinesis-ec2/aws | 0.2.1 |
| <a name="module_s3_loader_enriched"></a> [s3\_loader\_enriched](#module\_s3\_loader\_enriched) | snowplow-devops/s3-loader-kinesis-ec2/aws | 0.2.1 |
| <a name="module_s3_loader_raw"></a> [s3\_loader\_raw](#module\_s3\_loader\_raw) | snowplow-devops/s3-loader-kinesis-ec2/aws | 0.2.1 |
| <a name="module_s3_pipeline_bucket"></a> [s3\_pipeline\_bucket](#module\_s3\_pipeline\_bucket) | snowplow-devops/s3-bucket/aws | 0.1.1 |
| <a name="module_snowflake_loader"></a> [snowflake\_loader](#module\_snowflake\_loader) | snowplow-devops/snowflake-loader-ec2/aws | 0.2.0 |
| <a name="module_transformer_enriched_json"></a> [transformer\_enriched\_json](#module\_transformer\_enriched\_json) | snowplow-devops/transformer-kinesis-ec2/aws | 0.2.2 |
| <a name="module_transformer_enriched_parquet"></a> [transformer\_enriched\_parquet](#module\_transformer\_enriched\_parquet) | snowplow-devops/transformer-kinesis-ec2/aws | 0.2.2 |

## Resources

| Name | Type |
|------|------|
| [aws_key_pair.pipeline](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/key_pair) | resource |
| [aws_sqs_queue.message_queue](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/sqs_queue) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_cloudwatch_logs_enabled"></a> [cloudwatch\_logs\_enabled](#input\_cloudwatch\_logs\_enabled) | Whether application logs should be reported to CloudWatch | `bool` | `true` | no |
| <a name="input_cloudwatch_logs_retention_days"></a> [cloudwatch\_logs\_retention\_days](#input\_cloudwatch\_logs\_retention\_days) | The length of time in days to retain logs for | `number` | `7` | no |
| <a name="input_deltalake_auth_token"></a> [deltalake\_auth\_token](#input\_deltalake\_auth\_token) | Databricks deltalake auth token | `string` | `""` | no |
| <a name="input_deltalake_catalog"></a> [deltalake\_catalog](#input\_deltalake\_catalog) | Databricks deltalake catalog | `string` | `""` | no |
| <a name="input_deltalake_host"></a> [deltalake\_host](#input\_deltalake\_host) | Databricks deltalake host | `string` | `""` | no |
| <a name="input_deltalake_http_path"></a> [deltalake\_http\_path](#input\_deltalake\_http\_path) | Databricks deltalake http path | `string` | `""` | no |
| <a name="input_deltalake_port"></a> [deltalake\_port](#input\_deltalake\_port) | Databricks deltalake port | `string` | `""` | no |
| <a name="input_deltalake_schema"></a> [deltalake\_schema](#input\_deltalake\_schema) | Databricks deltalake schema | `string` | `""` | no |
| <a name="input_iam_permissions_boundary"></a> [iam\_permissions\_boundary](#input\_iam\_permissions\_boundary) | The permissions boundary ARN to set on IAM roles created | `string` | `""` | no |
| <a name="input_iglu_server_dns_name"></a> [iglu\_server\_dns\_name](#input\_iglu\_server\_dns\_name) | The DNS name of your Iglu Server | `string` | n/a | yes |
| <a name="input_iglu_super_api_key"></a> [iglu\_super\_api\_key](#input\_iglu\_super\_api\_key) | A UUIDv4 string to use as the master API key for Iglu Server management | `string` | n/a | yes |
| <a name="input_pipeline_db"></a> [pipeline\_db](#input\_pipeline\_db) | Database used by pipeline | `string` | n/a | yes |
| <a name="input_pipeline_kcl_write_max_capacity"></a> [pipeline\_kcl\_write\_max\_capacity](#input\_pipeline\_kcl\_write\_max\_capacity) | Increasing this is important to increase throughput at very high pipeline volumes | `number` | `50` | no |
| <a name="input_postgres_db_ip_allowlist"></a> [postgres\_db\_ip\_allowlist](#input\_postgres\_db\_ip\_allowlist) | An optional list of CIDR ranges to allow traffic from | `list(any)` | `[]` | no |
| <a name="input_postgres_db_name"></a> [postgres\_db\_name](#input\_postgres\_db\_name) | The name of the database to connect to | `string` | `""` | no |
| <a name="input_postgres_db_password"></a> [postgres\_db\_password](#input\_postgres\_db\_password) | The password to use to connect to the database | `string` | `""` | no |
| <a name="input_postgres_db_publicly_accessible"></a> [postgres\_db\_publicly\_accessible](#input\_postgres\_db\_publicly\_accessible) | Whether to make the Postgres RDS instance accessible over the internet | `bool` | `false` | no |
| <a name="input_postgres_db_username"></a> [postgres\_db\_username](#input\_postgres\_db\_username) | The username to use to connect to the database | `string` | `""` | no |
| <a name="input_prefix"></a> [prefix](#input\_prefix) | Will be prefixed to all resource names. Use to easily identify the resources created | `string` | n/a | yes |
| <a name="input_public_subnet_ids"></a> [public\_subnet\_ids](#input\_public\_subnet\_ids) | The list of public subnets to deploy the components across | `list(string)` | n/a | yes |
| <a name="input_s3_bucket_deploy"></a> [s3\_bucket\_deploy](#input\_s3\_bucket\_deploy) | Whether this module should create a new bucket with the specified name - if the bucket already exists set this to false | `bool` | `true` | no |
| <a name="input_s3_bucket_name"></a> [s3\_bucket\_name](#input\_s3\_bucket\_name) | The name of the S3 bucket events will be loaded into | `string` | n/a | yes |
| <a name="input_s3_bucket_object_prefix"></a> [s3\_bucket\_object\_prefix](#input\_s3\_bucket\_object\_prefix) | An optional prefix under which Snowplow data will be saved (Note: your prefix must end with a trailing '/') | `string` | `""` | no |
| <a name="input_snowflake_account"></a> [snowflake\_account](#input\_snowflake\_account) | Snowflake account to use | `string` | `""` | no |
| <a name="input_snowflake_database"></a> [snowflake\_database](#input\_snowflake\_database) | Snowflake database name | `string` | `""` | no |
| <a name="input_snowflake_loader_password"></a> [snowflake\_loader\_password](#input\_snowflake\_loader\_password) | The password to use for the loader user | `string` | `""` | no |
| <a name="input_snowflake_loader_role"></a> [snowflake\_loader\_role](#input\_snowflake\_loader\_role) | Snowflake role for loading snowplow data | `string` | `""` | no |
| <a name="input_snowflake_loader_user"></a> [snowflake\_loader\_user](#input\_snowflake\_loader\_user) | The Snowflake user used by Snowflake Loader | `string` | `""` | no |
| <a name="input_snowflake_region"></a> [snowflake\_region](#input\_snowflake\_region) | Region of Snowflake account | `string` | `""` | no |
| <a name="input_snowflake_schema"></a> [snowflake\_schema](#input\_snowflake\_schema) | Snowflake schema name | `string` | `""` | no |
| <a name="input_snowflake_transformed_stage_name"></a> [snowflake\_transformed\_stage\_name](#input\_snowflake\_transformed\_stage\_name) | Name of transformed stage | `string` | `""` | no |
| <a name="input_snowflake_warehouse"></a> [snowflake\_warehouse](#input\_snowflake\_warehouse) | Snowflake warehouse name | `string` | `""` | no |
| <a name="input_ssh_ip_allowlist"></a> [ssh\_ip\_allowlist](#input\_ssh\_ip\_allowlist) | The list of CIDR ranges to allow SSH traffic from | `list(any)` | n/a | yes |
| <a name="input_ssh_public_key"></a> [ssh\_public\_key](#input\_ssh\_public\_key) | The SSH public key to use for the deployment | `string` | n/a | yes |
| <a name="input_ssl_information"></a> [ssl\_information](#input\_ssl\_information) | The ARN of an Amazon Certificate Manager certificate to bind to the load balancer | <pre>object({<br>    enabled         = bool<br>    certificate_arn = string<br>  })</pre> | <pre>{<br>  "certificate_arn": "",<br>  "enabled": false<br>}</pre> | no |
| <a name="input_tags"></a> [tags](#input\_tags) | The tags to append to the resources in this module | `map(string)` | `{}` | no |
| <a name="input_telemetry_enabled"></a> [telemetry\_enabled](#input\_telemetry\_enabled) | Whether or not to send telemetry information back to Snowplow Analytics Ltd | `bool` | `true` | no |
| <a name="input_transformer_window_period_min"></a> [transformer\_window\_period\_min](#input\_transformer\_window\_period\_min) | Frequency to emit transforming finished message - 5,10,15,20,30,60 etc minutes | `number` | `5` | no |
| <a name="input_user_provided_id"></a> [user\_provided\_id](#input\_user\_provided\_id) | An optional unique identifier to identify the telemetry events emitted by this stack | `string` | `""` | no |
| <a name="input_vpc_id"></a> [vpc\_id](#input\_vpc\_id) | The VPC to deploy the components within | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_collector_dns_name"></a> [collector\_dns\_name](#output\_collector\_dns\_name) | The ALB dns name for the Pipeline Collector |
| <a name="output_postgres_db_address"></a> [postgres\_db\_address](#output\_postgres\_db\_address) | The RDS dns name where your data is being streamed |
| <a name="output_postgres_db_id"></a> [postgres\_db\_id](#output\_postgres\_db\_id) | The ID of the RDS instance |
| <a name="output_postgres_db_port"></a> [postgres\_db\_port](#output\_postgres\_db\_port) | The RDS port where your data is being streamed |
